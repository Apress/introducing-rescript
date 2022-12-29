// let totalLuggagePerPerson = luggage => {
//     var weights = [];
//     var currPerson = null;
//     var currWeight = 0;
//     luggage.forEach(item => {
//         var name = item[0];
//         var weight = item[1];
//         if (currPerson == null) {
//             currPerson = name;
//             currWeight = weight;
//         } else if (currPerson == name) {
//             currWeight = currWeight + weight;
//         } else {
//             weights.push([currPerson, currWeight]);
//         }
//     });
//     return weights;
// }

let totalLuggagePerPerson = luggage => {
    var weights = [];
    luggage.forEach(item => {
        var name = item[0];
        var weight = item[1];
        if (weights.length == 0) {
            weights.unshift([currPerson, currWeight])
        } else if (currPerson == name) {
            weights[0][1] += weight;
        } else {
            weights.unshift([currPerson, currWeight]);
        }
    });
    return weights;
}
