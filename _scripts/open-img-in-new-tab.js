let imgs = document.getElementsByTagName("img");

for (let i = 0; i < imgs.length; i++) {
    const source = imgs[i].src;
    const pre = "<a href='" + source + "' class='img-link' target='_blank' tabindex='-1' title='Open image in a new tab.'>";
    const post = "</a>"
    if (!imgs[i].parentElement.classList.contains("internal-link")) {
        imgs[i].outerHTML = pre + imgs[i].outerHTML + post;
    }
}