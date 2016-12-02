/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function requestSequence(ids, seqType, dType, seqHeader) {
    try {
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "getSequence");

        var dataIDS = document.createElement("input");
        dataIDS.setAttribute("type", "hidden");
        dataIDS.setAttribute("name", "ids");
        dataIDS.setAttribute("value", ids);
        form.appendChild(dataIDS);

        var dataSeqType = document.createElement("input");
        dataSeqType.setAttribute("type", "hidden");
        dataSeqType.setAttribute("name", "seqType");
        dataSeqType.setAttribute("value", seqType);
        form.appendChild(dataSeqType);

        var dataDType = document.createElement("input");
        dataDType.setAttribute("type", "hidden");
        dataDType.setAttribute("name", "dType");
        dataDType.setAttribute("value", dType);
        form.appendChild(dataDType);
        
         var dataDType = document.createElement("input");
        dataDType.setAttribute("type", "hidden");
        dataDType.setAttribute("name", "seqHeader");
        dataDType.setAttribute("value", seqHeader);
        form.appendChild(dataDType);
        
        document.body.appendChild(form);
        form.submit();
        //   document.getElementById('loadingPanel').style.display = "none";
        return true;
    } catch (err) {
        var txt = "Error al solicitar secuencias";
        txt += "Error description: " + err.message + "\n\n";

        alert(txt);
        return false;
    }
}
