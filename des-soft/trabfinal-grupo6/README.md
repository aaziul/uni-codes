# Inventory Controller and Metrics

This repository contains a containerized Java Web application designed to ingest inventory datasets via CSV files, performing automated processes to dynamically calculate real-time product distributions and risk statistics.

**Repo Link:** https://github.com/SW-Engineering-Courses-Karina-Kohl/trabalhofinal-turmab-grupo6_tlha

---

## Technologies Used

* **Java & Java Servlets** (Core backend processing)
* **JSP (Java Server Pages)** (Dynamic view rendering)
* **JavaScript** (Table filtering)
* **Apache Tomcat** (Web application server)
* **Maven** (Dependency management and build automation)
* **Docker & Docker Compose** (Containerization and environment reproducibility)
* **CSV File Processing** (Data ingestion pipeline)

---

## System Architecture

The application follows the traditional Java Web (MVC-like) architecture layer pattern:

```text
Browser ──> Servlet ──> Business Logic ──> CSV Processing ──> Metrics Calculation ──> JSP View ──> Browser
```

### Deployment Architecture
The entire web layer is encapsulated inside an isolated container to guarantee environment reproducibility across different operating systems:

```text
Docker Container ──> Apache Tomcat ──> Inventory Web Application (.war)
```

---

## How It Works

The system was designed as a sequential data processing pipeline divided into four main phases: **Upload**, **Validation**, **Classification**, and **Metrics Generation**.

Each row in the uploaded dataset is subjected to strict regulatory limits:

* **Discard (Expired):** Triggered if the item has already exceeded its expiry date.
* **Product Promotion:** Applied if the item is within 3 days of expiry.
* **Thermal Risk:** A critical alert triggered exclusively for the **Dairy** category if the recorded storage temperature exceeds **8.0°C**.
* **Normal Sale:** Default state assigned to safe and fully compliant items.

### Expected CSV Format


### A. Input Specification

To test the application, upload a `.csv` file matching the following structural pattern:

```csv
id_lote,produto,categoria,data_validade,temperatura_registro
401,Leite Integral,Laticinios,05/04/2026,12.5
402,Iogurte Natural,Laticinios,08/04/2026,6.0
403,Arroz Branco 5kg,Graos,20/12/2027,25.0
404,Queijo Prato,Laticinios,15/04/2026,10.0
405,Frango Resfriado,Carnes,07/04/2026,4.0
```

### B. Output Specification
After processing the business rules, the application generates a metrics dashboard in the web interface and makes available for download the file containing the following:

```csv
BATCH ID,PRODUCT,CATEGORY,EXPIRATION,TEMP,RECOMMENDED ACTION
401,Leite Integral,Laticinios,05/04/2026,12.5,Discard (Expired)
402,Iogurte Natural,Laticinios,08/04/2026,6.0,Promotion (Expiring Soon)
403,Arroz Branco 5kg,Graos,20/12/2027,25.0,Normal Sale  
404,Queijo Prato,Laticinios,15/04/2026,10.0,Thermal Risk (Above 8°C)
405,Frango Resfriado,Carnes,07/04/2026,4.0, Promotion (Expiring Soon)
```

---

## Deployment & Web Usage Guide

### Prerequisites
Make sure you have the following tools installed locally:
* [Docker & Docker Compose](https://docs.docker.com/get-docker/)
* [Maven](https://maven.apache.org/download.cgi)

### Running the Application

1. **Compile and package the source code into a web archive artifact (`.war`):**
   ```bash
   mvn clean package
   ```
   *The generated WAR file will be created inside the `target/` directory.*

2. **Build and start the application via Docker Compose:**
   ```bash
   # Run in foreground
   docker compose up --build
   ```

3. **Access the Web Interface:**
   Open your browser and navigate to:
   * **http://localhost:8080**

4. **Stopping the Application:**
   To stop the containers and free up system ports, execute:
   ```bash
   docker compose down
   ```

---

## Academic Context

This project was developed as the Final Project for the SOFTWARE DEVELOPMENT-INF01120 course, which covers object-oriented programming and software development techniques.

### Contributors (Group Members)
* Luiza Souto
* Thayssa Leão
* Henry
* Antônio Augusto

**Link for Group Trello (for organization):** https://trello.com/b/OrFsRfu9/trabalhofinal-tcp

---

## License
This repository was developed exclusively for academic purposes.