
.PHONY: clean

tangle_files = src/main.rs Cargo.toml

clean:
	@rm -rf target

$(tangle_files): src/hello.nw
	@mkdir -p target/rs/src
	@notangle -R$@ src/hello.nw > target/rs/$@

executable: $(tangle_files)
	@cd target/rs && cargo build --release 2> /dev/null
	@mkdir -p target/bin
	@cp target/rs/target/release/hello target/bin/hello

run: executable
	@target/bin/hello

target/latex/hello.tex: src/hello.nw
	@mkdir -p target/latex
	@noweave -delay -latex src/hello.nw > target/latex/hello.tex

book: target/latex/hello.tex
	@mkdir -p target/book
	@pdflatex -output-directory target/book target/latex/hello > /dev/null
