function add_line_tab(champ) {
    var lastRow = document.getElementById("ajout_multiple_ligne").lastChild;
    
    var newRow = lastRow.cloneNode(true);
    
    var indiceNew = $("#ajout_multiple_ligne tr").length;
    updateElementIds(newRow, indiceNew);
    
    copyElementValues(lastRow, newRow);
    
    document.getElementById("ajout_multiple_ligne").appendChild(newRow);
    
    $("#nombreLigne").val(indiceNew + 1);
    document.getElementById("checkbox"+indiceNew).value = indiceNew;
}

function confirmDeleteLine() {
    return confirm('Voulez-vous vraiment supprimer cet element ?');
}

function updateElementIds(element, newIndex) {
    
    var allElements = element.querySelectorAll("*");
    
    allElements.forEach(function (elem) {
        var currentId = elem.getAttribute("id");
        if (currentId) {
            var newId = currentId.replace(/\d+$/, newIndex);
            elem.setAttribute("id", newId);
        }
        var currentName = elem.getAttribute("name");
        if (currentName) {
            var newName = currentName.replace(/\d+$/, newIndex);
            elem.setAttribute("name", newName);
        }
        var currentClick = elem.getAttribute("onclick");
        if (currentClick) {
            var newClick = currentClick.replace(/\d+/g,newIndex);
            elem.setAttribute("onclick", newClick);
        }
    });
    
    element.setAttribute("id","ligne-multiple-"+newIndex);
}

function copyElementValues(sourceRow, targetRow) {
    
    var sourceFormElements = sourceRow.querySelectorAll("*");
    var targetFormElements = targetRow.querySelectorAll("*");
    
    for (var i = 0; i < sourceFormElements.length; i++) {
        var sourceElement = sourceFormElements[i];
        var targetElement = targetFormElements[i];
        
        if (sourceElement.tagName.toLowerCase() === targetElement.tagName.toLowerCase()) {
            targetElement.value = sourceElement.value;
        }
    }
}

function add_line_tabs(champ) {
    for (let i = 0; i < 10; i++) {
        var lastRow = document.getElementById("ajout_multiple_ligne").lastChild;
        
        var newRow = lastRow.cloneNode(true);
        
        var indiceNew = $("#ajout_multiple_ligne tr").length;
        updateElementIds(newRow, indiceNew);
        
        copyElementValues(lastRow, newRow);
        
        document.getElementById("ajout_multiple_ligne").appendChild(newRow);
        
        $("#nombreLigne").val(indiceNew + 1);
        document.getElementById("checkbox"+indiceNew).value = indiceNew;
    }
}
