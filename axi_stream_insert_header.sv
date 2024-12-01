module axi_stream_insert_header #(
    parameter  integer DATA_WD      = 32                  ,
    localparam integer DATA_BYTE_WD = DATA_WD / 8         ,
    localparam integer BYTE_CNT_WD  = $clog2(DATA_BYTE_WD)
) (
    input                           clk            ,
    input                           rstn           ,

    // In
    input                           valid_in       ,
    input        [     DATA_WD-1:0] data_in        ,
    input        [DATA_BYTE_WD-1:0] keep_in        ,
    input                           last_in        ,
    output                          ready_in       ,

    // Insert
    input                           valid_insert   ,
    input        [     DATA_WD-1:0] data_insert    ,
    input        [DATA_BYTE_WD-1:0] keep_insert    ,
    input        [ BYTE_CNT_WD-1:0] byte_insert_cnt,
    output reg                      ready_insert   ,

    // Output
    output                          valid_out      ,
    output       [     DATA_WD-1:0] data_out       ,
    output logic [DATA_BYTE_WD-1:0] keep_out       ,
    output                          last_out       ,
    input                           ready_out
);

    reg header_received;

    reg [     DATA_WD-1:0] cache_data  ;
    reg [DATA_BYTE_WD-1:0] header_keep ;
    reg [ BYTE_CNT_WD-1:0] header_bytes;

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

    wire [7:0] cache_data_bytes [DATA_BYTE_WD];
    wire [7:0] input_data_bytes [DATA_BYTE_WD];
    generate
        genvar i;
        for (i = 0; i < DATA_BYTE_WD; i=i+1) begin: g_byte
            assign cache_data_bytes[i] = cache_data[(i+1)*8-1:i*8];
            assign input_data_bytes[i] = data_in[(i+1)*8-1:i*8];
        end
    endgenerate

    wire [DATA_WD-1:0] data_comb;
    assign data_out = data_comb;

    generate
        genvar j;
        for (j = 0; j < DATA_BYTE_WD; j=j+1) begin: g_data_comb
            localparam integer IDX     = j               ;
            localparam integer REV_IDX = DATA_BYTE_WD-1-j;

            wire use_cache;
            assign use_cache = header_bytes>=REV_IDX;

            wire [$clog2(DATA_BYTE_WD)-1:0] cache_addr;
            assign cache_addr = header_bytes-REV_IDX;

            wire [$clog2(DATA_BYTE_WD)-1:0] input_addr;
            assign input_addr = header_bytes+IDX-DATA_BYTE_WD+1;

            assign data_comb[(IDX+1)*8-1:IDX*8] =
                use_cache ? cache_data_bytes[cache_addr] : input_data_bytes[input_addr];
        end
    endgenerate

    logic   [$clog2(BYTE_CNT_WD)-1:0] byte_in_cnt;
    integer                           bic        ;
    always_comb begin
        byte_in_cnt = ~('b0); // -1
        for (bic = 0; bic < DATA_BYTE_WD; bic=bic+1) begin
            if (keep_in[bic]) begin
                byte_in_cnt = byte_in_cnt + 1'b1;
            end
        end
    end

    wire [DATA_BYTE_WD-1+1:0] total_keep;
    assign total_keep = byte_in_cnt + byte_insert_cnt;

    localparam integer KEEP_OVERFLOW = DATA_BYTE_WD-1-1;

    wire keep_overflow;
    assign keep_overflow = total_keep>KEEP_OVERFLOW;

    reg last_in_d      ;
    reg keep_overflow_d;

    reg [DATA_BYTE_WD-1+1:0] total_keep_d;
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

    wire [DATA_BYTE_WD-1:0] keep_out_cnt;
    assign keep_out_cnt =
        overflow ?
        total_keep_d[DATA_BYTE_WD-1:0] :
        total_keep[DATA_BYTE_WD-1:0];

    assign keep_out[DATA_BYTE_WD-1] = 1'b1;

    genvar k;
    generate
        for (k = DATA_BYTE_WD-2; k >= 0; k=k-1) begin: g_convert_cnt
            assign keep_out[k] = keep_out_cnt>(DATA_BYTE_WD-1-k);
        end
    endgenerate

    assign last_out =
        overflow ?
        last_in_d :
        last_in;

    assign valid_out = header_received ? (valid_in | last_out) : 1'b0;
    assign ready_in  = header_received ? ready_out : 1'b0;

endmodule
