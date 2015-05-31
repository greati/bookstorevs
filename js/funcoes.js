function confirmarDelete() {
    return confirm("Você deseja mesmo deletar?");
}

function addFavoritos(url,title) {
        if (window.sidebar) window.sidebar.addPanel(title, url, "");
        else if (window.opera && window.print) {
            var mbm = document.createElement('a');
            mbm.setAttribute('rel', 'sidebar');
            mbm.setAttribute('href', url);
            mbm.setAttribute('title', title);
            mbm.click();
        }
        else if (document.all) {
            window.external.AddFavorite(url, title); 
        }
    }

function insereNumero(event, min, max) {
    if (min === "undefined") var min = 0;
    if (max === "undefined") var max = 2147483647;
    var element = event.target || event.srcElement;
    var typed = event.which || event.keyCode;
    var curValue = element.value;
    var newValue = typed != 8 ? curValue + String.fromCharCode(typed) : -1;
    var prevent = (newValue != -1) &&
                    (
                        !(typed >= 48 &&
                        typed <= 57 &&
                        ((parseInt(newValue) >= min && parseInt(newValue) <= max)))
                    );
    if (prevent) {
        alert("Este campo aceita apenas valores numéricos positivos entre "+min+" e "+max+".\nVocê digitou "+newValue+".");
        event.preventDefault(); 
    };
}