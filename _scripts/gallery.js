const links = document.querySelectorAll(".gallery2 a");

links.forEach(link => {
    link.addEventListener("mouseenter", () => {
        document.querySelectorAll(".gallery2 img").forEach(img => {
            img.classList.remove("dimmed");
        });
        document.querySelectorAll(".gallery2 img").forEach(img => {
            if (!link.contains(img)) {
                img.classList.add("dimmed");
            }
        });
    });

    link.addEventListener("mouseleave", () => {
        document.querySelectorAll(".gallery2 img").forEach(img => {
            img.classList.remove("dimmed");
        });
    });

    link.addEventListener("focus", () => {
        document.querySelectorAll(".gallery2 img").forEach(img => {
            if (!link.contains(img)) {
                img.classList.add("dimmed");
            }
        });
    });

    link.addEventListener("blur", () => {
        document.querySelectorAll(".gallery2 img").forEach(img => {
            img.classList.remove("dimmed");
        });
    });
});
