module parking_tb;
  parameter UNI_CAPACITY = 500;
  parameter MISC_CAPACITY = 200;
  parameter STEP = 50;

  reg car_entered;
  reg is_uni_car_entered;
  reg car_exited;
  reg is_uni_car_exited;
  reg clk;
  reg [5:0] hour;
  reg enabled;

  wire [9:0] uni_parked_car;
  wire [9:0] parked_car;
  wire [9:0] uni_vacated_space;
  wire [9:0] vacated_space;
  wire uni_is_vacated_space;
  wire is_vacated_space;
  wire fault;

  parking #(
    .UNI_CAPACITY(UNI_CAPACITY),
    .MISC_CAPACITY(MISC_CAPACITY),
    .STEP(STEP)
  ) uut (
    .car_entered(car_entered),
    .is_uni_car_entered(is_uni_car_entered),
    .car_exited(car_exited),
    .is_uni_car_exited(is_uni_car_exited),
    .clk(clk),
    .hour(hour),
    .enabled(enabled),
    .uni_parked_car(uni_parked_car),
    .parked_car(parked_car),
    .uni_vacated_space(uni_vacated_space),
    .vacated_space(vacated_space),
    .uni_is_vacated_space(uni_is_vacated_space),
    .is_vacated_space(is_vacated_space),
    .fault(fault)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    enabled = 1;
    hour = 8;
    car_entered = 0;
    is_uni_car_entered = 0;
    car_exited = 0;
    is_uni_car_exited = 0;

    $dumpfile("parking_tb.vcd");
    $dumpvars(0, parking_tb);

    $monitor("Time: %0t | Hour: %0d | Car Entered: %0b | Uni Car Entered: %0b | Car Exited: %0b | Uni Car Exited: %0b | Uni Parked Car: %0d | Parked Car: %0d | Uni Vacated Space: %0d | Vacated Space: %0d | uni_is_vacated_space: %0b | is_vacated_space: %0b | Fault: %0b", 
             $time, hour, car_entered, is_uni_car_entered, car_exited, is_uni_car_exited, uni_parked_car, parked_car, uni_vacated_space, vacated_space, uni_is_vacated_space, is_vacated_space, fault);

    // hour = 8:00
    repeat (50) begin
      #10 car_entered = $random % 2;
      is_uni_car_entered = $random % 2;
      car_exited = $random % 2;
      is_uni_car_exited = $random % 2;
    end

    // advance to 13:00
    hour = 13;
    repeat (50) begin
      #10 car_entered = $random % 2;
      is_uni_car_entered = $random % 2;
      car_exited = $random % 2;
      is_uni_car_exited = $random % 2;
    end
    
    // advance to 15:00
    hour = 15;
    repeat (10) begin
      #10 car_entered = $random % 2;
      is_uni_car_entered = $random % 2;
      car_exited = $random % 2;
      is_uni_car_exited = $random % 2;
    end

    // advance to 17:00
    hour = 17;
    // fill up the university section of the parking
    repeat (200) begin
      #10 car_entered = 1;
      is_uni_car_entered = 1;
      car_exited = 0;
      is_uni_car_exited = 0;
    end

    // Finish simulation
    #20 $finish;
  end
endmodule
