### Installation

* Clone the repository
```sh
git clone https://github.com/thomaslenzi/OptoHybridv2.git
```
* Once you cloned the repository, run the "tools/install.sh" script in order to download all the dependencies
```sh
./install.sh
```

### Project structure

- doc       Documentation
- prj       ISE project files
- src       VHDL & Verilog source files
- tools     Scripts that help the development process
- vendors   Third-party firmware/software

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
