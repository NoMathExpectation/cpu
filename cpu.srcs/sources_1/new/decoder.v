module decode32(read_data_1,read_data_2,Instruction,mem_data,ALU_result,
                 Jal,RegWrite,MemtoReg,RegDst,Sign_extend,clock,reset,opcplus4);
    output[31:0] read_data_1;               // 输出的第一操作数
    output[31:0] read_data_2;               // 输出的第二操作数
    input[31:0]  Instruction;               // 取指单元来的指令
    input[31:0]  mem_data;   				//  从DATA RAM or I/O port取出的数据
    input[31:0]  ALU_result;   				// 从执行单元来的运算的结果
    input        Jal;                       //  来自控制单元，说明是JAL指令 
    input        RegWrite;                  // 来自控制单元
    input        MemtoReg;              // 来自控制单元
    input        RegDst;             
    output[31:0] Sign_extend;               // 扩展后的32位立即数
    input		 clock,reset;                // 时钟和复位
    input[31:0]  opcplus4;                 // 来自取指单元，JAL中用



     // 输出
    output [31:0] read_data_1;    // 读数据1
    output [31:0] read_data_2;    // 读数据2
    output reg[31:0] Sign_extend;    // 立即数（符号拓展）


    // 指令集的划分
    wire [5:0]  opcode;
    wire [4:0]  rs;
    wire [4:0]  rt;
    wire [4:0]  rd;
    wire [4:0]  shamt;
    wire [5:0]  funct;
    wire [15:0] immediate;
    wire [25:0] address;
    assign opcode       = Instruction[31:26];
    assign rs           = Instruction[25:21];
    assign rt           = Instruction[20:16];
    assign rd           = Instruction[15:11];
    assign shamt        = Instruction[10:6];
    assign funct        = Instruction[5:0];
    assign immediate    = Instruction[15:0];
    assign address      = Instruction[25:0];


    // 32 个寄存器
    reg[31:0]   register[0:31];
    

    // 写寄存器
    reg[4:0]    write_register_address; // 写寄存器地址
    reg[31:0]   write_data;            // 写寄存器的数据


    // 符号位拓展
    wire    sign_bit; // 符号位值
    assign   sign_bit = immediate[15];
    wire    [15:0] sign_extend; // sing_bit 拓展到 16 bit
    assign   sign_extend = (sign_bit == 1'b1)? 16'b1111_1111_1111_1111:16'b0000_0000_0000_0000;


    // 读寄存器数据 read_data_1 和 read_data_2
    assign read_data_1 = register[rs];
    assign read_data_2 = register[rt];


    // 立即数拓展 Sign_extend
    always @(posedge clock) begin
        // 有符号 addi、addiu、lw
        // 无符号 andi、ori
        // andi、ori 无符号数拓展
        if(opcode == 6'b001101 || opcode == 6'b001101) begin
          Sign_extend <= {16'b0000_0000_0000_0000,immediate};
        end
        else begin
          Sign_extend <= {sign_extend,immediate};
        end
    end


    // 确定写寄存器的地址的来源
    always @(posedge clock) begin
        if(RegWrite == 1'b1) begin
            // Jal 指令
          if(Jal == 1'b1) begin
            write_register_address <= 5'b11111; // 32
          end
            // 如果不是 Jal 执行后面操作
            // 写寄存器目标来自 rd 字段
          else if(RegDst == 1'b1) begin
            write_register_address <= rd;
          end
           // 写寄存器的值来自 rt 字段
          else if (RegDst == 1'b0) begin
            write_register_address <= rt;
          end
        end
    end

    // 确定写寄存器数据的来源
    always @(posedge clock) begin
        if(RegWrite == 1'b1) begin
          // Jal 指令
          if(Jal == 1'b1) begin
            write_data <= opcplus4;
          end
            // 如果不是 Jal 执行后面操作
            // 0-写寄存器的数据来自 ALU
          else if(MemtoReg == 1'b0) begin
            write_data <= ALU_result;
          end
            // 1-写寄存器的数据来自数据存储器
          else if(MemtoReg == 1'b1) begin
            write_data <= mem_data;
          end
        end
    end



    // 写入寄存器
    integer i; // 指针
    always @(negedge clock) begin
        // 初始化寄存器数组
        if(reset == 1'b1) begin
          for(i = 0; i < 32; i = i + 1) register[i] <= 0;
        end
        else begin
            // // 1-寄存器堆写使能有效
            if(RegWrite == 1'b1) begin
              register[write_register_address] <= write_data;
            end
        end
    end
    

endmodule