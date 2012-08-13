module.exports = function(app) {

    app.get('/', function(req, res) {
        res.render('index', {title: 'Puzzli'});
    });

    app.get('/sudoku', function(req, res) {
        res.render('puzzle', {title: 'Sudoku'});
    })
};
