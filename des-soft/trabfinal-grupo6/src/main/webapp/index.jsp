<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8">
  <meta content="width=device-width, initial-scale=1.0" name="viewport">
  <title>Freshness Monitor - Data Administration</title>
  <script src="https://cdn.tailwindcss.com?plugins=forms,container-queries"></script>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap');
    body { font-family: 'Inter', sans-serif; }
    .sidebar-gradient { background: linear-gradient(180deg, #101828 0%, #0c111d 100%); }
    .custom-scrollbar::-webkit-scrollbar { width: 6px; }
    .custom-scrollbar::-webkit-scrollbar-track { background: #f1f5f9; }
    .custom-scrollbar::-webkit-scrollbar-thumb { background-color: #94a3b8; border-radius: 3px; }
    .custom-scrollbar::-webkit-scrollbar-thumb:hover { background-color: #64748b; }
  </style>
</head>
<body class="bg-slate-50 text-slate-900 min-h-screen flex">

<main class="flex-1 flex flex-col min-w-0">

  <!-- top bar -->
  <header class="h-16 px-8 flex items-center justify-between border-b border-slate-200 bg-white sticky top-0 z-10">
    <h2 class="text-lg font-bold text-slate-800">Freshness Monitor</h2>
  </header>

  <div class="p-8 max-w-6xl mx-auto w-full space-y-10">

    <!-- page title -->
    <section class="flex flex-col md:flex-row md:items-center justify-between gap-4">
      <div>
        <h1 class="text-3xl font-bold text-slate-900">Freshness Monitor</h1>
        <p class="text-slate-500 mt-1">Optimize your stock by identifying waste risks due to expiration or temperature.</p>
      </div>
      <div class="flex items-center gap-3">
        <a href="<%= request.getContextPath() %>/"
           class="px-6 py-2.5 text-sm font-semibold text-slate-700 bg-white border border-slate-300 rounded-lg hover:bg-slate-50 transition-colors">
          Clear
        </a>
        <button type="submit" form="uploadForm"
                class="px-6 py-2.5 text-sm font-semibold text-white bg-blue-600 rounded-lg hover:bg-blue-700 shadow-md shadow-blue-500/20 transition-all">
          Start Processing
        </button>
      </div>
    </section>

    <!-- pload + summary grid -->
    <section class="grid grid-cols-1 lg:grid-cols-3 gap-6">

      <!-- upload area -->
      <div class="lg:col-span-2 bg-white rounded-xl border border-slate-200 border-dashed p-10 flex flex-col items-center justify-center min-h-[340px]">
        <div class="w-16 h-16 bg-blue-50 text-blue-500 rounded-xl flex items-center justify-center mb-6">
          <svg class="h-8 w-8" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"
                  stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
          </svg>
        </div>
        <p class="text-xl font-bold text-slate-800 text-center">Drag &amp; Drop CSV file or click to browse</p>
        <p class="text-sm text-slate-400 mt-2">Maximum file size 25MB. Supports .csv</p>

        <form id="uploadForm" action="<%= request.getContextPath() %>/upload-csv"
              method="POST" enctype="multipart/form-data" class="mt-8 flex flex-col items-center gap-3">
          <label for="arquivo"
                 class="cursor-pointer px-6 py-2.5 bg-slate-100 text-slate-700 font-semibold text-sm rounded-lg border border-slate-200 hover:bg-slate-200 transition-colors">
            Select File
          </label>
          <input type="file" id="arquivo" name="csvFile" accept=".csv" required class="hidden"
                 onchange="updateFileStatus()">
          <p id="fileNameDisplay" class="text-sm text-slate-500 mt-2"></p>
        </form>
      </div>

      <!-- file summary -->
      <div class="space-y-6">
        <div class="bg-white rounded-xl border-l-4 border-l-blue-500 border border-slate-200 p-5 shadow-sm">
          <div class="flex items-center gap-2 mb-4">
            <svg class="h-4 w-4 text-slate-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
                    stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
            </svg>
            <span class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">File Summary</span>
          </div>

          <% String fileName = (String) request.getAttribute("fileName"); %>
          <% if (fileName != null && (List<?>) request.getAttribute("stockRows") != null && !((List<?>) request.getAttribute("stockRows")).isEmpty()) { %>
            <div class="mb-6">
              <h4 class="font-bold text-slate-800"><%= fileName %></h4>
              <p class="text-xs text-slate-500 mt-1">
                <%= request.getAttribute("fileSize") != null ? request.getAttribute("fileSize") + " • " : "" %>Processed just now
              </p>
            </div>
            <div class="bg-slate-50 rounded-lg p-3 flex justify-between items-center">
              <span class="text-[10px] font-bold text-green-600 uppercase tracking-widest">Processed Archive</span>
            </div>
          <% } else { %>
            <div id="pendingStatus" class="mb-6">
              <p class="text-sm text-slate-400">No file uploaded yet.</p>
            </div>
            <div class="bg-slate-50 rounded-lg p-3">
              <span id="statusBadge" class="text-[10px] font-bold text-slate-400 uppercase tracking-widest">Awaiting upload</span>
            </div>
          <% } %>

          <%-- Exibe mensagem de erro se existir --%>
          <% if (request.getAttribute("erro") != null) { %>
            <p class="mt-3 text-xs text-red-500 font-semibold"><%= request.getAttribute("erro") %></p>
          <% } %>
        </div>
      </div>
    </section>

    <!-- detailed ledger preview table -->
    <section class="space-y-4">
      <div class="flex flex-col md:flex-row md:items-end justify-between gap-4">
        <div class="flex items-center gap-8">
          <h3 class="text-xl font-bold text-slate-800">Detailed Ledger Preview</h3>
          <div class="flex bg-slate-100 p-1 rounded-lg">
            <button type="button" onclick="filterTable('all')" class="px-4 py-1 text-[11px] font-bold bg-blue-600 text-white rounded-md uppercase tracking-wider">All</button>
            <button type="button" onclick="filterTable('green')" class="px-4 py-1 text-[11px] font-bold text-slate-500 hover:text-slate-800 rounded-md uppercase tracking-wider">Normal Sale</button>
            <button type="button" onclick="filterTable('orange')" class="px-4 py-1 text-[11px] font-bold text-slate-500 hover:text-slate-800 rounded-md uppercase tracking-wider">Warning</button>
            <button type="button" onclick="filterTable('red')" class="px-4 py-1 text-[11px] font-bold text-slate-500 hover:text-slate-800 rounded-md uppercase tracking-wider">Expired</button>
          </div>
        </div>
        <a href="<%= request.getContextPath() %>/download-csv"
           class="flex items-center gap-2 px-5 py-2.5 bg-white border border-slate-300 text-blue-600 text-xs font-bold rounded-lg hover:bg-blue-50 transition-colors uppercase tracking-widest">
          <svg class="h-4 w-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
                  stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
          </svg>
          DOWNLOAD CSV
        </a>
      </div>

      <div class="bg-white border border-slate-200 rounded-xl overflow-hidden shadow-sm flex flex-col max-h-screen">
        <div class="overflow-x-auto overflow-y-auto flex-1">
          <table class="w-full text-left border-collapse min-w-full">
          <thead class="sticky top-0 bg-white z-20">
            <tr class="border-b border-slate-100 bg-white">
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest w-20 whitespace-nowrap">BATCH ID</th>
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">PRODUCT</th>
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">CATEGORY</th>
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">EXPIRATION</th>
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest whitespace-nowrap">TEMP.</th>
              <th class="px-3 md:px-6 py-4 text-[10px] font-bold text-slate-400 uppercase tracking-widest text-right whitespace-nowrap">RECOMMENDED ACTION</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-slate-50">
            <%
              List<?> rows = (List<?>) request.getAttribute("stockRows");
              if (rows != null && !rows.isEmpty()) {
                for (Object rowObj : rows) {
                  // [0]=batchId, [1]=product, [2]=category, [3]=expiration, [4]=temp, [5]=action, [6]=actionColor
                  String[] row = (String[]) rowObj;
                  String color = row[6]; // ex: "red", "orange", "green"
                  String badgeBg = "bg-slate-50 text-slate-500";
                  String actionColor = "text-slate-500";
                  if ("red".equals(color))    { badgeBg = "bg-red-50 text-red-500";       actionColor = "text-red-500"; }
                  if ("orange".equals(color)) { badgeBg = "bg-orange-50 text-orange-500"; actionColor = "text-orange-500"; }
                  if ("green".equals(color))  { badgeBg = "bg-green-50 text-green-600";   actionColor = "text-green-600"; }
            %>
            <tr class="hover:bg-slate-50 transition-colors" data-color="<%= color %>">
              <td class="px-3 md:px-6 py-5 text-xs md:text-sm font-semibold text-slate-500 whitespace-nowrap"><%= row[0] %></td>
              <td class="px-3 md:px-6 py-5 text-xs md:text-sm font-bold text-slate-800 whitespace-nowrap"><%= row[1] %></td>
              <td class="px-3 md:px-6 py-5 text-xs md:text-sm text-slate-500 whitespace-nowrap"><%= row[2] %></td>
              <td class="px-3 md:px-6 py-5">
                <span class="px-2.5 py-0.5 rounded text-[10px] font-bold uppercase <%= badgeBg %>"><%= row[3] %></span>
              </td>
              <td class="px-3 md:px-6 py-5 text-xs md:text-sm text-slate-500 whitespace-nowrap"><%= row[4] %></td>
              <td class="px-3 md:px-6 py-5 text-right font-bold text-xs <%= actionColor %> whitespace-nowrap"><%= row[5] %></td>
            </tr>
            <%  }
              } else { %>
            <tr>
              <td colspan="6" class="px-6 py-10 text-center text-sm text-slate-400">
                No data available. Upload a CSV file to see results.
              </td>
            </tr>
            <% } %>
          </tbody>
        </table>
        </div>
        <div class="bg-slate-50/50 px-6 py-4 border-t border-slate-100">
          <% List<?> rowsFooter = (List<?>) request.getAttribute("stockRows"); %>
          <% if (rowsFooter != null) { %>
            <span class="text-xs text-slate-400"><%= rowsFooter.size() %> record(s) found</span>
          <% } %>
        </div>
      </div>
    </section>

  </div>
</main>

<!-- floating download button -->
<div class="fixed bottom-6 right-8">
  <a href="<%= request.getContextPath() %>/download-csv"
     class="flex items-center gap-3 bg-[#0c111d] text-white px-5 py-3 rounded-xl shadow-2xl hover:scale-105 transition-transform group">
    <span class="text-xs font-bold uppercase tracking-widest">DOWNLOAD CSV</span>
    <div class="bg-blue-600 p-1.5 rounded-lg group-hover:bg-blue-500 transition-colors">
      <svg class="h-5 w-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
        <path d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l-4-4m0 0L8 8m4-4v12"
              stroke-linecap="round" stroke-linejoin="round" stroke-width="2"/>
      </svg>
    </div>
  </a>
</div>

<script>
  const uploadArea = document.querySelector('.lg\\:col-span-2');
  const fileInput = document.getElementById('arquivo');

  // Drag and drop listeners
  uploadArea.addEventListener('dragover', (e) => {
    e.preventDefault();
    e.stopPropagation();
    uploadArea.classList.add('bg-blue-50', 'border-blue-400');
  });

  uploadArea.addEventListener('dragleave', (e) => {
    e.preventDefault();
    e.stopPropagation();
    uploadArea.classList.remove('bg-blue-50', 'border-blue-400');
  });

  uploadArea.addEventListener('drop', (e) => {
    e.preventDefault();
    e.stopPropagation();
    uploadArea.classList.remove('bg-blue-50', 'border-blue-400');
    
    const files = e.dataTransfer.files;
    if (files.length > 0) {
      const csvFile = files[0];
      if (csvFile.type === 'text/csv' || csvFile.name.endsWith('.csv')) {
        fileInput.files = files;
        updateFileStatus();
      } else {
        alert('Select a valid CSV file.');
      }
    }
  });

  function updateFileStatus() {
    const fileInput = document.getElementById('arquivo');
    const fileName = fileInput.files[0]?.name;
    const fileNameDisplay = document.getElementById('fileNameDisplay');
    const statusBadge = document.getElementById('statusBadge');
    const pendingStatus = document.getElementById('pendingStatus');

    if (fileName) {
      fileNameDisplay.innerText = fileName;
      if (pendingStatus) {
        pendingStatus.innerHTML = `<p class="text-sm text-slate-600 font-semibold">${fileName}</p>`;
      }
      statusBadge.className = 'text-[10px] font-bold text-blue-600 uppercase tracking-widest';
      statusBadge.innerText = 'Ready to Process';
    }
  }

  function filterTable(filterColor) {
    const rows = document.querySelectorAll('table tbody tr[data-color]');
    rows.forEach(row => {
      if (filterColor === 'all') {
        row.style.display = '';
      } else {
        row.style.display = row.getAttribute('data-color') === filterColor ? '' : 'none';
      }
    });

    document.querySelectorAll('.flex.bg-slate-100 button').forEach(btn => btn.classList.remove('bg-blue-600', 'text-white'));
    event.target.classList.add('bg-blue-600', 'text-white');
  }
</script>

</body>
</html>