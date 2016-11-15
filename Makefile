
.PHONY: clean

clean:
	@rm -rf target

target/rs/src/hello.rs: src/hello.nw
	@mkdir -p target/rs/src
	@notangle -Rhello.rs src/hello.nw > target/rs/src/hello.rs

target/rs/Cargo.toml: src/hello.nw
	@mkdir -p target/rs
	@notangle -RCargo.toml src/hello.nw > target/rs/Cargo.toml

compile: target/rs/src/hello.rs target/rs/Cargo.toml
	@cd target/rs && cargo build --release
	@mkdir -p target/bin
	@cp target/rs/target/release/hello target/bin/hello

run: compile
	@target/bin/hello

target/latex/hello.tex: src/hello.nw
	@mkdir -p target/latex
	@noweave -latex src/hello.nw > target/latex/hello.tex

manual: target/latex/hello.tex
	@mkdir -p target/manual
	@pdflatex -output-directory target/manual target/latex/hello
