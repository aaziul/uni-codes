package br.edu.ufrgs.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import br.edu.ufrgs.model.CSVModel;
import br.edu.ufrgs.model.InventoryManagement;
import br.edu.ufrgs.model.ItemStock;
import br.edu.ufrgs.model.StockAction;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet({"/upload-csv", "/download-csv"}) // servlet to handle both upload and download actions
@MultipartConfig
public class CSVController extends HttpServlet {
    private CSVModel model = new CSVModel();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Part archivePart = request.getPart("csvFile"); // get uploaded file from the request

            // extract file metadata (name and formatted size)
            String fileName = archivePart.getSubmittedFileName(); 
            long fileSizeBytes = archivePart.getSize();
            String fileSize = formatFileSize(fileSizeBytes);

            // read original csv content using the model
            InputStream fileContent = archivePart.getInputStream();
            List<String> data = model.readFile(fileContent);

            List<String[]> stockRows = new ArrayList<>();
            InventoryManagement gerenciador = new InventoryManagement();
            
            // setup date formatters (input from csv, output to table)
            DateTimeFormatter inputDateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter outputDateFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");

            // process each line of the csv, dont include the header
            for (int i = 1; i < data.size(); i++) {
                String line = data.get(i).trim();
                if (line.isEmpty()) continue; // skip empty lines

                String[] campos = line.split(",");
                
                try {
                    // extract and parse column data
                    int batchId = Integer.parseInt(campos[0].trim());
                    String product = campos[1].trim();
                    String category = campos[2].trim();
                    LocalDate expirationDate = LocalDate.parse(campos[3].trim(), inputDateFormatter);
                    double recordedTemperature = Double.parseDouble(campos[4].trim());

                    ItemStock item = new ItemStock(batchId, product, category, expirationDate, recordedTemperature);

                    // verify action
                    item = gerenciador.verifyAction(item);

                    // data to table
                    String[] rowData = new String[7];
                    rowData[0] = String.valueOf(batchId);                           // batchId
                    rowData[1] = product;                                           // product 
                    rowData[2] = category;                                          // category 
                    rowData[3] = expirationDate.format(outputDateFormatter);        // expiration 
                    rowData[4] = String.format("%.1f°C", recordedTemperature);      // temp
                    rowData[5] = getActionDescription(item.getStockAction());       // action 
                    rowData[6] = getColorForAction(item.getStockAction());           // color

                    stockRows.add(rowData);
                } catch (Exception e) {
                    System.err.println("Error processing line " + (i + 1) + ": " + e.getMessage());
                }
            }

            // set attributes to display data on interface
            request.setAttribute("fileName", fileName);
            request.setAttribute("fileSize", fileSize);
            request.setAttribute("stockRows", stockRows);

            // save data in session so it can be downloaded later via doGet
            request.getSession().setAttribute("stockRows", stockRows);
            request.getSession().setAttribute("downloadFileName", fileName);

        } catch (Exception e) {
            request.setAttribute("erro", "Error processing the file: " + e.getMessage());
        }

        request.getRequestDispatcher("index.jsp").forward(request, response);
    }

    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<String[]> stockRows = (List<String[]>) request.getSession().getAttribute("stockRows"); // retrieve processed data from session

        // redirect to home if there is no data to download
        if (stockRows == null || stockRows.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        // generate dynamic filename for the download
        String originalFileName = (String) request.getSession().getAttribute("downloadFileName");
        String downloadName = (originalFileName != null && !originalFileName.isBlank())
                ? originalFileName.replaceAll("(?i)\\.csv$", "") + "_processed.csv"
                : "processed_stock.csv";

        response.setContentType("text/csv; charset=UTF-8");
        response.setHeader("Content-Disposition", "attachment; filename=\"" + downloadName + "\"");
        response.setCharacterEncoding("UTF-8");

        List<String> newCsvLines = model.createCsv(stockRows); // generate the new csv content

        // write lines to the downloaded file
        PrintWriter writer = response.getWriter();
        for (String line : newCsvLines) {
            writer.println(line);
        }

        writer.flush();
    }

    // format file size
    private String formatFileSize(long bytes) {
        if (bytes < 1024) return bytes + " B";
        if (bytes < 1024 * 1024) return String.format("%.1f KB", bytes / 1024.0);
        return String.format("%.1f MB", bytes / (1024.0 * 1024));
    }

    // format color for action
    private String getColorForAction(StockAction action) {
        switch (action) {
            case PRODUCT_DISCARD:
                return "red";           // expiring
            case PRODUCT_PROMOTION:
            case THERMAL_RISK:
                return "orange";        // promotion or thermal risk
            case NORMAL_SALE:
            default:
                return "green";         // normal sale or unknown action
        }
    }

    // format action description
    private String getActionDescription(StockAction action) {
        switch (action) {
            case NORMAL_SALE:
                return "Normal Sale";
            case PRODUCT_PROMOTION:
                return "Promotion (Expiring Soon)";
            case PRODUCT_DISCARD:
                return "Discard (Expired)";
            case THERMAL_RISK:
                return "Thermal Risk (Above 8°C)";
            default:
                return "Unknown";
        }
    }
}

