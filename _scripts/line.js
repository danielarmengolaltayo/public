// function setup() {
//     let cnv = createCanvas(windowWidth, windowHeight);
//     cnv.parent("canvas-container");
//     noLoop();
// }

// function draw() {
//     background(255);

//     if (draw.id) {
//         const d = 10; //diameter dots

//         // console.log("id A: " + draw.id)
//         const aParent = document.getElementById(draw.id).parentNode;

//         let a = getAbsPosition(document.getElementById(draw.id));
//         let bArray = draw.id.substring(1).split("/");
//         let bId = "/" + bArray[1] + "/" + bArray[0];
//         // console.log("id B: " + bId)
//         let b = getAbsPosition(document.getElementById(bId));

//         strokeWeight(2);
//         stroke(255, 219, 0);
//         line(a.r + 10, a.m, b.l - 10, b.m);
//     }
// }

// function windowResized() {
//     resizeCanvas(windowWidth, windowHeight);
// }

// function stopDrawing() {
//     draw.id = null;
//     noLoop();
// }

// function resumeDrawing(id) {
//     draw.id = id;
//     loop();
// }

// function getAbsPosition(element) {
//     let rect = element.getBoundingClientRect();
//     let mid = Math.round((rect.bottom - rect.top) / 2) + rect.top;
//     return { l: rect.left, b: rect.bottom, r: rect.right, t: rect.top, m: mid }
// }