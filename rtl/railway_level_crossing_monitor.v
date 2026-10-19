// ============================================================
// Railway Level Crossing Monitor
// SKY130 RTL-to-GDSII ASIC Design Project
//
// Verifies the safe sequence of a level crossing and raises a
// fail-safe alarm on violation or timeout.
//
// Macro-free Verilog-2005. Constants defined via localparam.
// ============================================================

module railway_level_crossing_monitor (
    input  wire       clk,
    input  wire       reset,
    input  wire       train_approach,
    input  wire       train_depart,
    input  wire       light_on_sensor,
    input  wire       barrier_down_sensor,
    input  wire       barrier_up_sensor,
    output reg        fail_safe,
    output reg        sequence_ok,
    output reg  [2:0] error_code
);

    // ----------------------------------------------------------
    // FSM state encoding (3-bit binary)
    // ----------------------------------------------------------
    localparam [2:0] S_IDLE    = 3'b000;
    localparam [2:0] S_WARN    = 3'b001;
    localparam [2:0] S_BARRIER = 3'b010;
    localparam [2:0] S_PASSING = 3'b011;
    localparam [2:0] S_CLEAR   = 3'b100;
    localparam [2:0] S_FAULT   = 3'b101;

    // ----------------------------------------------------------
    // Error codes
    // ----------------------------------------------------------
    localparam [2:0] ERR_NONE            = 3'b000;
    localparam [2:0] ERR_TIMEOUT_BARRIER = 3'b001;
    localparam [2:0] ERR_BARRIER_EARLY   = 3'b010;
    localparam [2:0] ERR_DEPART_EARLY    = 3'b011;
    localparam [2:0] ERR_BARRIER_STRAY   = 3'b100;
    localparam [2:0] ERR_TIMEOUT_CLEAR   = 3'b101;
    localparam [2:0] ERR_TIMEOUT_WARN    = 3'b110;
    localparam [2:0] ERR_TIMEOUT_PASSING = 3'b111;

    // ----------------------------------------------------------
    // Timeout limits (in clk cycles)
    // ----------------------------------------------------------
    localparam [7:0] LIMIT_WARN    = 8'd200;
    localparam [7:0] LIMIT_BARRIER = 8'd250;
    localparam [7:0] LIMIT_PASSING = 8'd255;
    localparam [7:0] LIMIT_CLEAR   = 8'd200;

    // ----------------------------------------------------------
    // Sequential elements (14 flip-flops total)
    // ----------------------------------------------------------
    reg [2:0] state;         // FSM state register
    reg [7:0] counter;       // shared timeout counter
    reg [2:0] error_code_r;  // latched error code

    // ----------------------------------------------------------
    // FSM + counter + error register
    // ----------------------------------------------------------
    always @(posedge clk) begin
        if (reset) begin
            state        <= S_IDLE;
            counter      <= 8'd0;
            error_code_r <= ERR_NONE;
        end
        else begin
            case (state)

                // -------- S_IDLE: no train, all clear --------
                S_IDLE: begin
                    counter <= 8'd0;
                    if (train_approach) begin
                        state <= S_WARN;
                    end
                    else if (barrier_down_sensor) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_BARRIER_STRAY;
                    end
                    else if (train_depart) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_DEPART_EARLY;
                    end
                end

                // -------- S_WARN: lights should turn ON --------
                S_WARN: begin
                    if (light_on_sensor) begin
                        state   <= S_BARRIER;
                        counter <= 8'd0;
                    end
                    else if (barrier_down_sensor) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_BARRIER_EARLY;
                    end
                    else if (train_depart) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_DEPART_EARLY;
                    end
                    else if (counter >= LIMIT_WARN) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_TIMEOUT_WARN;
                    end
                    else begin
                        counter <= counter + 8'd1;
                    end
                end

                // -------- S_BARRIER: barrier should go DOWN --------
                S_BARRIER: begin
                    if (barrier_down_sensor) begin
                        state   <= S_PASSING;
                        counter <= 8'd0;
                    end
                    else if (counter >= LIMIT_BARRIER) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_TIMEOUT_BARRIER;
                    end
                    else begin
                        counter <= counter + 8'd1;
                    end
                end

                // -------- S_PASSING: train is crossing --------
                S_PASSING: begin
                    if (train_depart) begin
                        state   <= S_CLEAR;
                        counter <= 8'd0;
                    end
                    else if (counter >= LIMIT_PASSING) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_TIMEOUT_PASSING;
                    end
                    else begin
                        counter <= counter + 8'd1;
                    end
                end

                // -------- S_CLEAR: barrier should go UP --------
                S_CLEAR: begin
                    if (barrier_up_sensor) begin
                        state   <= S_IDLE;
                        counter <= 8'd0;
                    end
                    else if (counter >= LIMIT_CLEAR) begin
                        state        <= S_FAULT;
                        error_code_r <= ERR_TIMEOUT_CLEAR;
                    end
                    else begin
                        counter <= counter + 8'd1;
                    end
                end

                // -------- S_FAULT: latched until reset --------
                S_FAULT: begin
                    counter <= 8'd0;
                end

                // -------- Safety default --------
                default: begin
                    state        <= S_IDLE;
                    counter      <= 8'd0;
                    error_code_r <= ERR_NONE;
                end

            endcase
        end
    end

    // ----------------------------------------------------------
    // Combinational outputs
    // ----------------------------------------------------------
    always @(*) begin
        // Safe defaults
        fail_safe   = 1'b0;
        sequence_ok = 1'b0;
        error_code  = ERR_NONE;

        if (state == S_FAULT) begin
            fail_safe   = 1'b1;
            sequence_ok = 1'b0;
            error_code  = error_code_r;
        end
        else if (state == S_IDLE) begin
            fail_safe   = 1'b0;
            sequence_ok = 1'b0;
            error_code  = ERR_NONE;
        end
        else begin
            // S_WARN, S_BARRIER, S_PASSING, S_CLEAR
            fail_safe   = 1'b0;
            sequence_ok = 1'b1;
            error_code  = ERR_NONE;
        end
    end

endmodule
