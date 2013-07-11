package com.pdf.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import org.apache.pdfbox.cos.COSDocument;
import org.apache.pdfbox.pdfparser.PDFParser;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDPage;
import org.apache.pdfbox.util.PDFTextStripper;

public class PDFTextParser {
	private PDFParser parser = null;

	public PDFTextParser(String fileName) {
		File file = new File(fileName);
		if (!file.isFile()) {
			System.err.println("No file");
		}
		try {
			parser = new PDFParser(new FileInputStream(file));

		} catch (IOException e) {
			System.err.println("Unabe to open PDF");

		}
	}

	public String getParsedText() {
		PDDocument pdDoc = null;
		COSDocument cosDoc = null;
		String parsedText = null;

		try {
			PDFTextStripper pdfStripper = new PDFTextStripper();
			parser.parse();
			cosDoc = parser.getDocument();
			pdDoc = new PDDocument(cosDoc);

			List<PDPage> list = pdDoc.getDocumentCatalog().getAllPages();
			pdfStripper.setStartPage(1);
			pdfStripper.setEndPage(list.size());
			parsedText = pdfStripper.getText(pdDoc);
		} catch (IOException e) {

		} finally {
			try {
				if (cosDoc != null) {
					cosDoc.close();
				}
				if (pdDoc != null) {
					pdDoc.close();
				}
			} catch (IOException e) {

			}
		}
		return parsedText;
	}

	public static void main(String args[]) {
		PDFTextParser pdf = new PDFTextParser(
				"/Users/Simon/Downloads/StiborLIBOR.pdf");
		System.out.println(pdf.getParsedText());
	}

}
