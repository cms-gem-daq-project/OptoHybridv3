### Project structure

- doc       Documentation
- prj       ISE project files
- src       VHDL & Verilog source files
---- gbt        GBT source files 
-------- vendor     GBT-FPGA project files
---- ics        Interfaces to ICs on the OptoHybrid
---- ipcores    Xilinx cores 
---- packages   Types & constants definition
---- routines   High-level software routines implemented in firmware
---- seu        SEU tools
---- system     Functions that compose the backbone of the architecture
---- tests      Test benches
---- ucf        User Constraints Files
---- vfat2      Low-level VFAT2 functions
- tools     Scripts that help the development process

### Design guidelines

- Only use IN and OUT modes
- Give _i or _o suffixes to signals
- Vectors always start at 0
- Vectors always go from MSB downto LSB
- Use synchronous resets
- Initialize all signals in reset
- All signals are active high
- Use the rising edge of the clock
- Synchronous processes only have the clock as sensitive signal
- The file’s name is the entity’s name
- Use testbenches
- Testbenches are named after the entity with the _test suffix
- Use named signal mapping for entities
- Cover all the cases in conditions
- Use constants when possible
