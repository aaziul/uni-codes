package br.edu.ufrgs.model;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

public class CSVModel {
    // read file function -> read content on csv file
    public List<String> readFile(InputStream file) {
        List<String> readLines = new ArrayList<>(); // array to store read lines

        // InputStream in bytes is converted to InputStreamReader in characters and then passed to BufferedReader to read lines 
        try (BufferedReader br = new BufferedReader(new InputStreamReader(file))) { 
            String line;

            // read file line by line till the end and add to readLines array
            while ((line = br.readLine()) != null) { 
                readLines.add(line);
            }
        } catch (IOException e) {
            readLines.add("Error reading file: " + e.getMessage());
        }

        return readLines;
    }

    // upload file function -> create the new csv file with a new column of action nedded on product
    public List<String> createCsv(List<String[]> stockRows) {
        List<String> csvLines = new ArrayList<>();
        
        // header on the new file
        csvLines.add("BatchID,Product,Category,Expiration,Temperature,Recommended Action");

        // transform each column array in one line
        for (String[] row : stockRows) {
            // row: [0]=batchId, [1]=product, [2]=category, [3]=expiration, [4]=temp, [5]=action
            String formatedLine = String.format("%s,%s,%s,%s,%s,%s",
                    escapeCsv(row[0]), 
                    escapeCsv(row[1]), 
                    escapeCsv(row[2]),
                    escapeCsv(row[3]), 
                    escapeCsv(row[4]), 
                    escapeCsv(row[5])
            );
            csvLines.add(formatedLine);
        }

        return csvLines;
    }

    // format data rule
    private String escapeCsv(String value) {
        if (value == null) return "";
        if (value.contains(",") || value.contains("\"") || value.contains("\n")) {
            return "\"" + value.replace("\"", "\"\"") + "\"";
        }
        return value;
    }
}