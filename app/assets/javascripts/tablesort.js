// Function to sort a given table via a given collumn via a 0-indexed number and
// the type of content contained in the column (String, Date, Num)
// returns the sorted data
function sortTable(tablename, colnum, coltype) {
  function sortDate(a, b){
    aDate = new Date(a[colnum])
    bDate = new Date(b[colnum])
    if (aDate == bDate){
      return 0;
    } else if(aDate == "Invalid Date") {
      return 1
    } else if(bDate == "Invalid Date") {
      return -1
    }else if(aDate>bDate){
      return -1;
    } else{
      return 1;
    }
  }

  function sortNum(a, b){
    aNum = a[colnum]
    bNum = b[colnum]
    if (aNum == bNum){
      return 0;
    } else if(aNum>bNum){
      return 1;
    } else{
      return -1;
    }
  }

  function sortString(a, b){
    strA=a[colnum].toLowerCase()
    strB=b[colnum].toLowerCase()
    if (strA==strB){
      return 0;
    } else if([strA,strB].sort()[0] == strA){
      return -1;
    } else{
      return 1;
    }
  }

  table=document.getElementById(tablename).tBodies[0].rows
  rawdata=[]
  rawcoldata=[]
  i=0
  while (i<table.length) {
    row=table[i].cells
    temp=[]
    n=0
    while (n<row.length){
        temp.push(row[n].innerHTML)
        n++
    }
    i+=1
    rawdata.push(temp)
    rawcoldata.push(temp[colnum])
  }

  if (coltype=="Date"){
    rawdata.sort(sortDate)
  } else if (coltype=="Num") {
    rawdata.sort(sortNum)
  } else {
    rawdata.sort(sortString)
  }
  return rawdata
}

// Variable to keep track of what is sorted and by how
// Negative values means the data was reversed after sorting
// Thus the value is +/-(colnum+1) as 0==-0 (Even though -0 exists in JS)
sortedTables={}

function sortIndicatorHandler(tablename, colnum){
  //Reset the header if previously sorted
  if (sortedTables[tablename]){
    sortedHeader=document.getElementById(tablename).tHead.rows[0].cells[Math.abs(sortedTables[tablename])-1].innerHTML
    fixedHeader=sortedHeader.split("<!-- sortIndicator -->")[0]+"<!-- sortIndicator --> ▲▼"
    document.getElementById(tablename).tHead.rows[0].cells[Math.abs(sortedTables[tablename])-1].innerHTML=fixedHeader
  }
  //Set the header to mark the new sorted col
  colHeader=document.getElementById(tablename).tHead.rows[0].cells[colnum].innerHTML
  if (sortedTables[tablename]==colnum+1){
    colHeader=colHeader.split("<!-- sortIndicator -->")[0]+"<!-- sortIndicator --> ▼"
  } else{
    colHeader=colHeader.split("<!-- sortIndicator -->")[0]+"<!-- sortIndicator --> ▲"
  }
  document.getElementById(tablename).tHead.rows[0].cells[colnum].innerHTML=colHeader
}

// Wrapper to write the table out and reverse the data if already sorted via that
// column
function tableSortWrapper(tablename, colnum, coltype){
  data = sortTable(tablename, colnum, coltype)
  // Set the indicator before the data because we need to preserve the old sortedTables
  // for a value check in sortIndicatorHandler
  sortIndicatorHandler(tablename, colnum)
  if (colnum==sortedTables[tablename]-1){
    data.reverse()
    sortedTables[tablename]=(0-(colnum+1))
  } else {
    sortedTables[tablename]=colnum+1
  }
  table=document.getElementById(tablename).tBodies[0].rows
  i=0
  while (i<table.length) {
    row=table[i].cells
    n=0
    while (n<row.length){
        row[n].innerHTML=data[i][n]
        n++
    }
    i+=1
  }
}

// Initializes tablesort for a given table
// colnum is for the default sorted column if applicable
function tableSortInit(tablename, colnum){
  tableHeader=document.getElementById(tablename).tHead.rows[0].cells
  i=0
  while (i<tableHeader.length){
    headerText = tableHeader[i].innerHTML
    if (headerText!=""){
      tableHeader[i].innerHTML = tableHeader[i].innerHTML+"<!-- sortIndicator --> ▲▼"
    }
    i++
  }
  if (colnum != undefined){
    sortIndicatorHandler(tablename,colnum)
    sortedTables[tablename]=(colnum+1)
  }
}