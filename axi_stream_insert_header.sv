module axi_stream_insert_header (
    input               clk            ,
    input               rstn           ,

    // In
    input               valid_in       ,
    input        [31:0] data_in        ,
    input        [ 3:0] keep_in        ,
    input               last_in        ,
    output              ready_in       ,

    // Insert
    input               valid_insert   ,
    input        [31:0] data_insert    ,
    input        [ 3:0] keep_insert    ,
    input        [ 1:0] byte_insert_cnt,
    output reg          ready_insert   ,

    // Output
    output              valid_out      ,
    output       [31:0] data_out       ,
    output logic [ 3:0] keep_out       ,
    output              last_out       ,
    input               ready_out
);

    reg header_received;

    reg [31:0] cache_data  ;
    reg [ 3:0] header_keep ;
    reg [ 1:0] header_bytes;

    always @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            header_received <= #1 'b0;
            cache_data      <= #1 'b0;
            header_keep     <= #1 'b0;
            header_bytes    <= #1 'b0;
            ready_insert    <= #1 'b1;
        end else if (valid_insert && ready_insert && ~header_received) begin
            header_received <= #1 1'b1;
            cache_data      <= #1 data_insert;
            header_keep     <= #1 keep_insert;
            header_bytes    <= #1 byte_insert_cnt;
            ready_insert    <= #1 1'b0;
        end else begin
            if (header_received && valid_in && ready_in) begin
                cache_data <= #1 data_in;
            end
            if (last_out && valid_out && ready_out) begin
                header_received <= #1 valid_insert && ready_insert;
                ready_insert    <= #1 1'b1;
            end
        end
    end

    logic [7:0] cache_data_bytes[4];
    assign cache_data_bytes[0] = cache_data[07:00];
    assign cache_data_bytes[1] = cache_data[15:08];
    assign cache_data_bytes[2] = cache_data[23:16];
    assign cache_data_bytes[3] = cache_data[31:24];

    logic [7:0] input_data_bytes[4];
    assign input_data_bytes[0] = data_in[07:00];
    assign input_data_bytes[1] = data_in[15:08];
    assign input_data_bytes[2] = data_in[23:16];
    assign input_data_bytes[3] = data_in[31:24];

    logic [31:0] data_comb;
    assign data_out = data_comb;

    always_comb begin
        case (header_bytes)
            2'b00   : data_comb = {cache_data_bytes[0], input_data_bytes[3], input_data_bytes[2], input_data_bytes[1]};
            2'b01   : data_comb = {cache_data_bytes[1], cache_data_bytes[0], input_data_bytes[3], input_data_bytes[2]};
            2'b10   : data_comb = {cache_data_bytes[2], cache_data_bytes[1], cache_data_bytes[0], input_data_bytes[3]};
            2'b11   : data_comb = {cache_data_bytes[3], cache_data_bytes[2], cache_data_bytes[1], cache_data_bytes[0]};
            default : data_comb = 'b0;
        endcase
    end

    integer bic;

    logic [1:0] byte_in_cnt;
    always_comb begin
        case (keep_in)
            4'b1000   : byte_in_cnt = 2'b00;
            4'b1100   : byte_in_cnt = 2'b01;
            4'b1110   : byte_in_cnt = 2'b10;
            4'b1111   : byte_in_cnt = 2'b11;
            default : byte_in_cnt = 2'b00;
        endcase
    end

    wire [3+1:0] total_keep;
    assign total_keep = byte_in_cnt + byte_insert_cnt;

    localparam integer KEEP_OVERFLOW = 3-1;

    wire keep_overflow;
    assign keep_overflow = total_keep>KEEP_OVERFLOW;

    reg last_in_d      ;
    reg keep_overflow_d;

    reg [3+1:0] total_keep_d;
    always_ff @(posedge clk or negedge rstn) begin
        if (~rstn) begin
            last_in_d       <= #1 'b0;
            total_keep_d    <= #1 'b0;
            keep_overflow_d <= #1 'b0;
        end else begin
            last_in_d       <= #1 last_in;
            total_keep_d    <= #1 total_keep - KEEP_OVERFLOW;
            keep_overflow_d <= #1 keep_overflow;
        end
    end

    wire overflow;
    assign overflow = keep_overflow || keep_overflow_d;

    wire [3:0] keep_out_cnt;
    assign keep_out_cnt =
        overflow ?
        total_keep_d[3:0] :
        total_keep[3:0];

    always_comb begin
        case (keep_out_cnt)
            'b00: keep_out = 4'b1000;
            'b01: keep_out = 4'b1100;
            'b10: keep_out = 4'b1110;
            'b11: keep_out = 4'b1111;
            default: keep_out = 4'b0000; // ERROR
        endcase
    end

    assign last_out =
        overflow ?
        last_in_d&&(~last_in) :
        last_in;

    wire transparent;
    assign transparent = header_received || (valid_insert && ready_insert);

    assign valid_out = transparent ? (valid_in | last_out) : 1'b0;
    assign ready_in  = transparent ? ready_out : 1'b0;

endmodule
