
.PHONY: clean

rust_source = main.rs

clean:
	@rm -rf target

$(rust_source): src/hello.nw
	@mkdir -p target/rs/src
	@notangle -R$@ src/hello.nw > target/rs/src/$@

target/rs/Cargo.toml: src/hello.nw
	@mkdir -p target/rs
	@notangle -RCargo.toml src/hello.nw > target/rs/Cargo.toml

executable: $(rust_source) target/rs/Cargo.toml
	@cd target/rs && cargo build --release
	@mkdir -p target/bin
	@cp target/rs/target/release/hello target/bin/hello

run: executable
	@target/bin/hello

target/latex/hello.tex: src/hello.nw
	@mkdir -p target/latex
	@noweave -latex src/hello.nw > target/latex/hello.tex

book: target/latex/hello.tex
	@mkdir -p target/manual
	@pdflatex -output-directory target/manual target/latex/hello
