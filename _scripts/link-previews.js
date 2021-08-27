function hideTooltip(event) {
    document.getElementById(event.target.pathname).style.display = "none";
    // stopDrawing();
    // leaderline.hide("none");
    removeLine();
}

function showTooltip(event) {
    document.getElementById(event.target.pathname).style.display = "block";
    // resumeDrawing(event.target.id);

    // let a = document.getElementById(event.target.id);
    // let bArray = event.target.id.substring(1).split("/");
    // let bId = "/" + bArray[1] + "/" + bArray[0];
    // let b = document.getElementById(bId);

    // if (!leaderline) {
    //     createLeaderLine(a, b);
    // }
    // leaderline.start = a;
    // leaderline.end = b;
    // leaderline.show("none");

    createLine(event.target.id);
}

function setupListeners(linkElement) {
    linkElement.addEventListener('mouseleave', function (_event) {
        linkElement.blur();
    });
    linkElement.addEventListener('blur', function (event) {
        hideTooltip(event);
    });
    linkElement.addEventListener('mouseenter', function (event) {
        document.activeElement.blur();
        linkElement.focus();
    });
    linkElement.addEventListener('focus', function (event) {
        showTooltip(event);
    });
    document.getElementById("right").addEventListener('mousemove', function (event) {
        linkElement.blur();
    });
    document.addEventListener('scroll', function (event) {
        // if (leaderline) {
        //     leaderline.position();
        // }
        if (lineCreated) {
            updateLine();
        }
    });
}

// document.querySelectorAll('{{ include.wrapperQuerySelector }} a').forEach(setupListeners);
document.querySelectorAll('content .internal-link').forEach(setupListeners);

var internalLinks = document.getElementsByClassName("internal-link");
for (var i = 0; i < internalLinks.length; i++) {
    if (internalLinks[i].href == window.location.href) {
        internalLinks[i].classList.add("highlight-backlink");
    }
}

// leader line
// var leaderline;
// function createLeaderLine(a, b) {
//     leaderline = new LeaderLine(
//         LeaderLine.areaAnchor(a, { color: 'red' }),
//         LeaderLine.areaAnchor(b, { color: 'red' }),
//         {
//             hide: true,
//             color: "rgba(255, 219, 0, 1)",
//             path: "straight",
//             startPlug: 'behind',
//             endPlug: 'behind',
//             size: 2,
//             startSocket: 'right',
//             endSocket: 'left'
//         });
// }

// SVG line 
var lineCreated = false;
var aElement, bElement;

function createLine(aId) {
    aElement = document.getElementById(aId);
    let bArray = aId.substring(1).split("/");
    let bId = "/" + bArray[1] + "/" + bArray[0];
    bElement = document.getElementById(bId);
    updateLine();
    lineCreated = true;
}

function updateLine() {
    let a = aElement.getBoundingClientRect();
    let b = bElement.getBoundingClientRect();
    let margin = 10;
    let x1 = a.right + margin;
    let x2 = b.left - margin;
    let y1 = a.top + ((a.bottom - a.top) / 2);
    let y2 = b.top + ((b.bottom - b.top) / 2);
    document.getElementById("line-container").innerHTML = '<line id="line" x1="' + x1 + '" y1="' + y1 + '" x2="' + x2 + '" y2="' + y2 + '"/>';
}

function removeLine() {
    document.getElementById("line-container").innerHTML = "";
    lineCreated = false;
}