# Define variables
TYPST_FILE = main.typ
MAIN_PDF = main.pdf
DOC_PDF = doc/wissensch_Redlichkeit_E_09-2023.pdf
OUTPUT_PDF = output.pdf

# Default target
all: $(OUTPUT_PDF)

# Compile Typst file into main.pdf
$(MAIN_PDF): $(TYPST_FILE)
	typst compile $(TYPST_FILE) $(MAIN_PDF)

# Merge main.pdf and the doc file
$(OUTPUT_PDF): $(MAIN_PDF) $(DOC_PDF)
	pdfunite $(MAIN_PDF) $(DOC_PDF) $(OUTPUT_PDF)

# Clean up intermediate files
clean:
	rm -f $(MAIN_PDF) $(OUTPUT_PDF)

count: 
	pdftotext main.pdf - | wc -w