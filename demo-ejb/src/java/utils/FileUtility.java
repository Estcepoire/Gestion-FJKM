/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;

import com.itextpdf.text.Document;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.extractor.WordExtractor;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;

/**
 *
 * @author sarobidy
 */
public class FileUtility {
          
          static Set<String> OFFICE_DOCUMENTS = new HashSet<>(Arrays.asList(
              new String[] { "odt", "ods"}
          ));
          
          static Set<String> WORD_DOCUMENTS = new HashSet<>(Arrays.asList(
              new String[] { "doc", "docx" }
          ));
          static Set<String> PORTABLE_DOCUMENTS = new HashSet<>(Arrays.asList(
              new String[] { "pdf" }
          ));
          static Set<String> MS_EXCEL_DOCUMENTS = new HashSet<>(Arrays.asList(
              new String[] { "xls", "xlsx" }
          ));
          
          static Set<String> AUDIO = new HashSet<>(Arrays.asList(
              new String[] { "mp3", "mp4", "wav", "ogg", "flac" }
          ));
          
          static Set<String> VIDEO = new HashSet<>(Arrays.asList(
              new String[] { "mp4", "3gp", "webm", "aac"}
          ));
          
          static Set<String> IMAGES = new HashSet<>(Arrays.asList(
              new String[] { "jpg", "jpeg", "png", "tiff", "gif", "bmp"}
          ));
          
          static Set<String> TEXT = new HashSet<>(Arrays.asList(
              new String[] { "txt", "php", "java", "py", "html", "css", "js", "rb" }
          ));
          
          // Oky manana enum de afaka miasa tsara
          public static boolean isDocument( String extension ){
                    return WORD_DOCUMENTS.contains(extension) || MS_EXCEL_DOCUMENTS.contains(extension);
          }
          
          public static boolean isText(String extension){
                    return TEXT.contains(extension);
          }
          
          public static boolean isMedia(String extension){
                    return AUDIO.contains(extension) || VIDEO.contains(extension);
          }
          
          
          public static byte[] convertDocumentToBytes( String extension, File word ) throws Exception{
                    // Si ods ou odt ne pas traité
                    // Okey let's go
                    if( OFFICE_DOCUMENTS.contains(extension) ){
                              return new byte[0];
                    }
                    FileInputStream fis = new FileInputStream(word);
                    ByteArrayOutputStream bytes = new ByteArrayOutputStream();
                    
                    
                    Document pdfDocument = new Document();
                    PdfWriter writer = PdfWriter.getInstance(pdfDocument, bytes);
                   
                    if( extension.equalsIgnoreCase("doc") ) convertDocToBytes(fis, pdfDocument);
                    if( extension.equalsIgnoreCase("docx") ) convertDocxToBytes(fis, pdfDocument);
                    if( MS_EXCEL_DOCUMENTS.contains(extension)  ) convertXlsToBytes(fis, pdfDocument);
                   
                    // Close the documents
                    pdfDocument.close();
//                    document

                    // Return the PDF bytes
                    return bytes.toByteArray();
                    
          }
          
          static void convertDocToBytes( FileInputStream fis, Document pdfDocument ) throws Exception{
                    POIFSFileSystem fs = new POIFSFileSystem(fis);
                    HWPFDocument document = new HWPFDocument(fs);
                    WordExtractor extractor  = new WordExtractor(document);
                    
                    pdfDocument.open();
                    pdfDocument.newPage();
                    
                     Range range = document.getRange();
                    String[] paragraphs = extractor.getParagraphText();
                    for (int i = 0; i < paragraphs.length; i++) {
                        org.apache.poi.hwpf.usermodel.Paragraph pr = range.getParagraph(i);

                        // Clean up the paragraph text
                        paragraphs[i] = paragraphs[i].replaceAll("\\cM?\r?\n", "");
//                        System.out.println("Length: " + paragraphs[i].length());
                        System.out.println("Paragraph " + i + ": " + paragraphs[i]);

                        // Add the paragraph to the PDF document
                        pdfDocument.add(new com.itextpdf.text.Paragraph(paragraphs[i]));
                    }
          }
          
          static void convertDocxToBytes(FileInputStream fis, Document pdfDocument) throws Exception{
                    XWPFDocument document = new XWPFDocument(fis);
                    pdfDocument.open();
                    pdfDocument.newPage();
                    List<XWPFParagraph> paragraphs = document.getParagraphs();
                     for ( XWPFParagraph paragraph : paragraphs ) {
                              String text = paragraph.getText();
                              if (!text.isEmpty()) {
                                  pdfDocument.add(new Paragraph(text, FontFactory.getFont(FontFactory.HELVETICA, 12)));
                              }
                    }
          }
          
          // Okey excel indray zao
          static void convertXlsToBytes(FileInputStream fis, Document pdfDocument) throws Exception{
                    Workbook workbook = WorkbookFactory.create(fis);
                    pdfDocument.open();
                    pdfDocument.newPage();
                    for (int i = 0; i < workbook.getNumberOfSheets(); i++) {
                              Sheet sheet = workbook.getSheetAt(i);
                              pdfDocument.add(new Paragraph("Sheet: " + sheet.getSheetName(), FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14)));
                              PdfPTable table = new PdfPTable(sheet.getRow(0).getLastCellNum());

                              for (Row row : sheet) {
                                  for (Cell cell : row) {
                                      table.addCell(getCellValueAsString(cell));
                                  }
                              }
                              pdfDocument.add(table);
                              pdfDocument.newPage(); // Start a new page for the next sheet
                    }
          }
          
          private static String getCellValueAsString(Cell cell) {
          if (cell == null) {
              return "";
          }
          switch (cell.getCellType()) {
              case Cell.CELL_TYPE_STRING:
                  return cell.getStringCellValue();
              case Cell.CELL_TYPE_NUMERIC:
                  if (DateUtil.isCellDateFormatted(cell)) {
                      return cell.getDateCellValue().toString();
                  }
                  return String.valueOf(cell.getNumericCellValue());
              case Cell.CELL_TYPE_BOOLEAN:
                  return String.valueOf(cell.getBooleanCellValue());
              case Cell.CELL_TYPE_FORMULA:
                  return cell.getCellFormula();
              default:
                  return "";
          }
      }
          
          // Rehefa vita ny excel de ny pdf indray izao
          
}
