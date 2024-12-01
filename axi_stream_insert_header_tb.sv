module axi_stream_insert_header_tb ;

    reg clk ;
    reg rstn;
    initial begin
        clk = 0;
        rstn = 0;
        #35;
        rstn = 1;
    end
    initial begin
        forever #10 clk = ~clk;
    end


    reg         valid_in;
    reg  [31:0] data_in ;
    reg  [ 3:0] keep_in ;
    reg         last_in ;
    wire        ready_in;

    reg         valid_insert   ;
    reg  [31:0] data_insert    ;
    reg  [ 3:0] keep_insert    ;
    reg  [ 1:0] byte_insert_cnt;
    wire        ready_insert   ;

    wire        valid_out;
    wire [31:0] data_out ;
    wire [ 3:0] keep_out ;
    wire        last_out ;
    reg         ready_out;

    axi_stream_insert_header #(.DATA_WD(32)) u_axi_stream_insert_header (
        .clk            (clk            ),
        .rstn           (rstn           ),
        // In
        .valid_in       (valid_in       ),
        .data_in        (data_in        ),
        .keep_in        (keep_in        ),
        .last_in        (last_in        ),
        .ready_in       (ready_in       ),
        // Insert
        .valid_insert   (valid_insert   ),
        .data_insert    (data_insert    ),
        .keep_insert    (keep_insert    ),
        .byte_insert_cnt(byte_insert_cnt),
        .ready_insert   (ready_insert   ),
        // Out
        .valid_out      (valid_out      ),
        .data_out       (data_out       ),
        .keep_out       (keep_out       ),
        .last_out       (last_out       ),
        .ready_out      (ready_out      )
    );

    integer in;
    task automatic send_data();
        wait(ready_in==1);
        #20;
        last_in  = 1'b0;
        data_in  = 32'hAA_BB_CC_00;
        valid_in = 1'b1;
        for (in = 0; in < 5; in=in+1) begin
            #20;
            data_in = data_in + 1;
        end
        #20;
        keep_in  = 4'b1100;
        last_in = 1'b1;
        data_in = 32'hFF_FF_12_34;
        valid_in = 1'b1;
        #20;
        last_in = 1'b0;
        #1;
    endtask : send_data

    initial begin
        keep_in  = 'b0;
        data_in  = 'h0;
        last_in  = 'b0;
        valid_in = 'b0;

        send_data();
        send_data();

        keep_in  = 'b0;
        last_in  = 'b0;
        data_in  = 'h0;
        valid_in = 'b0;

        #100;

        $finish;
    end

    initial begin
        #1;
        valid_insert    = 0;
        data_insert     = 0;
        keep_insert     = 0;
        byte_insert_cnt = 0;

        ready_out = 0;

        ready_out = 1'b1;

        #50;

        valid_insert = 1;
        data_insert = 32'hAB_CD_EF_88;
        keep_insert = 4'b0001;
        byte_insert_cnt = 2'd0;

        #20;

        ready_out = 1'b1;
    end

endmodule
