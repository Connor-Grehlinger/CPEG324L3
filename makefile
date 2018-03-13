verify: calc_verify

calc_verify: ./build/add_sub_8.o ./build/InstrFetch.o ./build/RegFile.o ./build/printer.o ./build/brancher.o ./build/twoscomp.o ./build/calc_single.o ./build/calc_single_verification.o 
	ghdl -e --workdir=./build --ieee=standard calc_single_verification
	ghdl -r --workdir=./build --ieee=standard calc_single_verification --vcd=calc_single_verification.vcd


test: calc_tb

calc_tb: ./build/add_sub_8.o ./build/InstrFetch.o ./build/RegFile.o ./build/printer.o ./build/brancher.o ./build/twoscomp.o ./build/calc_single.o ./build/calc_single_tb.o 
	ghdl -e --workdir=./build --ieee=standard calc_single_tb
	ghdl -r --workdir=./build --ieee=standard calc_single_tb --vcd=calc_single_tb.vcd

./build/add_sub_8.o: ./add_sub_8/add_sub_8.vhdl
	ghdl -a --workdir=./build --ieee=standard ./add_sub_8/add_sub_8.vhdl

./build/InstrFetch.o: ./InstrFetch/InstrFetch.vhdl
	ghdl -a --workdir=./build --ieee=standard ./InstrFetch/InstrFetch.vhdl

./build/RegFile.o: ./build/shift_reg_8.o ./RegFile/RegFile.vhdl
	ghdl -a --workdir=./build --ieee=standard ./RegFile/RegFile.vhdl

./build/shift_reg_8.o: ./build/shift_reg.o ./RegFile/shift_reg_8.vhdl
	ghdl -a --workdir=./build --ieee=standard ./RegFile/shift_reg_8.vhdl

./build/shift_reg.o: ./RegFile/shift_reg.vhdl
	ghdl -a --workdir=./build --ieee=standard ./RegFile/shift_reg.vhdl

./build/printer.o: ./printer/printer.vhdl
	ghdl -a --workdir=./build --ieee=standard ./printer/printer.vhdl

./build/brancher.o: ./brancher/brancher.vhdl
	ghdl -a --workdir=./build --ieee=standard ./brancher/brancher.vhdl

./build/twoscomp.o: ./twoscomp/twoscomp.vhdl
	ghdl -a --workdir=./build --ieee=standard ./twoscomp/twoscomp.vhdl

./build/calc_single.o: ./calc_single/calc_single.vhdl
	ghdl -a --workdir=./build --ieee=standard ./calc_single/calc_single.vhdl


./build/calc_single_tb.o: ./calc_single/calc_single_tb.vhdl
	ghdl -a --workdir=./build --ieee=standard ./calc_single/calc_single_tb.vhdl

./build/calc_single_verification.o: ./calc_single/calc_single_verification.vhdl
	ghdl -a --workdir=./build --ieee=standard ./calc_single/calc_single_verification.vhdl

clean:
	rm ./build/*.o ./build/*.cf ./build/calc_single_tb
