module parking #(
  parameter UNI_CAPACITY = 500,
  parameter MISC_CAPACITY = 200,
  parameter STEP = 50
) (
  input wire car_entered,
  input wire is_uni_car_entered,
  input wire car_exited,
  input wire is_uni_car_exited,
  input wire clk,
  input wire [5:0] hour,
  input wire enabled,
  output reg [9:0] uni_parked_car,
  output reg [9:0] parked_car,
  output reg [9:0] uni_vacated_space,
  output reg [9:0] vacated_space,
  output wire uni_is_vacated_space,
  output wire is_vacated_space,
  output reg fault
);

  initial begin
    uni_parked_car = 0;
    parked_car = 0;
    fault = 0;
  end

  always @(posedge clk) begin
    if (enabled) begin

      if (car_entered) begin
        if (is_uni_car_entered && uni_vacated_space > 0) begin
          uni_parked_car = uni_parked_car + 1;
        end else if (!is_uni_car_entered && vacated_space > 0) begin
          parked_car = parked_car + 1;
        end
      end

      if (car_exited) begin
        if (is_uni_car_exited && uni_parked_car > 0) begin
          uni_parked_car = uni_parked_car - 1;
        end else if (!is_uni_car_exited && parked_car > 0) begin
          parked_car = parked_car - 1;
        end
      end

      if (hour >= 8 && hour < 13) begin
        uni_vacated_space <= UNI_CAPACITY - uni_parked_car;
        vacated_space <= MISC_CAPACITY - parked_car;
      end else if (hour >= 13 && hour < 16) begin
        uni_vacated_space <= UNI_CAPACITY - (hour - 12) * STEP - uni_parked_car;
        vacated_space <= MISC_CAPACITY + (hour - 12) * STEP - parked_car;
      end else if (hour >= 16) begin
        uni_vacated_space <= MISC_CAPACITY - uni_parked_car;
        vacated_space <= UNI_CAPACITY - parked_car;
      end


      if ((hour >= 13 && hour < 16 && UNI_CAPACITY < (hour - 12) * STEP + uni_parked_car) ||
          (hour >= 16 && (MISC_CAPACITY < uni_parked_car || UNI_CAPACITY < parked_car))) begin
        fault <= 1;
      end else begin
        fault <= 0;
      end
    end
  end

  assign uni_is_vacated_space = uni_vacated_space > 0;
  assign is_vacated_space = vacated_space > 0;

endmodule

