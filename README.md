# Parking-Management-System-DSD-Final-Project

This project implements a parking management system in Verilog. The system manages parking spaces for university cars and other cars with different capacities and rules based on the time of day. It calculates the number of parked cars, the number of vacated spaces, and flags any faults if the capacity constraints are violated.

## Project Description

The parking management system is designed to:
1. Track the number of university and non-university cars parked.
2. Calculate the number of available parking spaces.
3. Handle different parking rules based on the time of day.
4. Flag faults if the parking constraints are violated.

### Inputs

- **car_entered**: A signal indicating that a car has entered the parking lot.
- **is_uni_car_entered**: A signal indicating that the entered car belongs to the university.
- **car_exited**: A signal indicating that a car has exited the parking lot.
- **is_uni_car_exited**: A signal indicating that the exited car belongs to the university.
- **clk**: The clock signal.
- **hour**: The current hour (0-23) of the day, provided as a 6-bit input.
- **enabled**: A signal to enable or disable the parking management system.

### Outputs

- **uni_parked_car**: The number of university cars currently parked.
- **parked_car**: The number of non-university cars currently parked.
- **uni_vacated_space**: The number of available spaces for university cars.
- **vacated_space**: The number of available spaces for non-university cars.
- **uni_is_vacated_space**: A signal indicating if there are any available spaces for university cars.
- **is_vacated_space**: A signal indicating if there are any available spaces for non-university cars.
- **fault**: A signal indicating a fault if the parking constraints are violated.

## Files

### `parking.v`

This file contains the Verilog code for the parking management system. It implements the logic to manage parking spaces, handle different rules based on the time of day, and flag faults if constraints are violated.

### `parking_tb.v`

This file contains the testbench for the parking management system. It generates random signals to simulate car entries and exits in different hours of the day.

### `parking_tb.vcd`

This file contains the Value Change Dump (VCD) generated from the simulation. It records all the changes in the signals during the simulation, which can be viewed using GTKWave.

### `out.txt`

This file contains the textual output of the simulation run, including any debug information, errors, or logs produced by the testbench.

### `DSD-Final-401105912.pdf` 

This is brief report of the project written in Persian.
