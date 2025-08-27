function adjustGrid() {
    const gallery = document.getElementById('flickr-gallery');
    const images = gallery.children.length;
    const galleryWidth = gallery.offsetWidth;
    const galleryHeight = gallery.offsetHeight;

    // Calcular el número de columnas óptimo
    let cols = Math.round(Math.sqrt((images * galleryWidth) / galleryHeight));
    let rows = Math.ceil(images / cols);
    // Calcular el tamaño del cuadrado
    let imageSize = Math.min(galleryWidth / cols, galleryHeight / rows);
    imageSize = Math.floor(imageSize);

    gallery.style.gridTemplateColumns = `repeat(${cols}, ${imageSize}px)`;

    // const wrap = document.getElementById('flickr_wrap');
    // wrap.setAttribute('style', 'flex-wrap: wrap');
}

window.addEventListener('resize', adjustGrid);
window.addEventListener('load', adjustGrid);

