module.exports = function(app) {

    app.get('/', function(req, res) {
        res.render('index', {title: 'Puzzli'});
    });

    app.get('/puzzles/sudoku', function(req, res) {
        res.render('puzzles/sudoku', {});
    })
};
