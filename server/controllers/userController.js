const mysql = require('mysql');

const pool = mysql.createPool({
    connectionLimit: 100,
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME
});

exports.view = (req, res) => {
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);

        //User the connection
        connection.query('SELECT id, first_name, last_name, password as pass_word, email, comments FROM virtual_users WHERE status = "active"', (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                let removedUser = req.query.removed;
                res.render('home', { rows, removedUser });
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}

exports.find = (req, res) => {
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);

        let searchTerm = req.body.search;

        //User the connection
        connection.query('SELECT id, first_name, last_name, password as pass_word, email, comments FROM virtual_users WHERE first_name LIKE ? OR last_name LIKE ? OR email LIKE ?',['%' + searchTerm + '%', '%' + searchTerm + '%', '%' + searchTerm + '%'], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                res.render('home', { rows });
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}

exports.form = (req, res) => {
    res.render('add-user');
};

// add new user
exports.create = (req, res) => {
    const { first_name, last_name, email, pass_word, phone, comments } = req.body;
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);

        let searchTerm = req.body.search;

        //User the connection
        connection.query('INSERT INTO virtual_users SET domain_id = ?, first_name = ?, last_name = ?, email = ?, password = TO_BASE64(UNHEX(SHA2(?, 512))), phone = ?, comments = ?, status = ?', [1,first_name, last_name, email, pass_word, `99364019767`, comments, 'active'], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                res.render('add-user', { alert: 'User added successfully.'});
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}

// edit user
exports.edit = (req, res) => {
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);
        console.log(req.params.id);
        //User the connection
        connection.query('SELECT id, first_name, last_name, password as pass_word, email, comments FROM virtual_users WHERE id = ?', [req.params.id], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                res.render('edit-user', { rows });
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}
// update user
exports.update = (req, res) => {
    const { first_name, last_name, email, pass_word, phone, comments } = req.body;
    pool.getConnection((err, connection) => {
        if (err) throw err; // not connected!
        console.log('Connected as ID ' + connection.threadId);
        console.log(req.params.id);
        //Use the connection
        connection.query('UPDATE virtual_users SET first_name = ?, last_name = ?, email =?, password = TO_BASE64(UNHEX(SHA2(?, 512))), comments = ? WHERE id = ?', [first_name, last_name, email, pass_word, comments, req.params.id], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                pool.getConnection((err, connection) => {
                    if (err) throw err;
                    console.log('Connected as ID ' + connection.threadId);
                    console.log(req.params.id);
                    //User the connection
                    connection.query('SELECT id, first_name, last_name, password as pass_word, email, comments FROM virtual_users WHERE id = ?', [req.params.id], (err, rows) => {
                        // When done with the connection, release it
                        connection.release();
                        if (!err) {
                            res.render('edit-user', { rows, alert: `${first_name} has been updated` });
                        } else {
                            console.log(err);
                        }
                        console.log('The data from user table: \n', rows);
                    });
                });
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}

// fully delete user
//exports.delete = (req, res) => {
//    pool.getConnection((err, connection) => {
//        if (err) throw err;
//        console.log('Connected as ID ' + connection.threadId);
//        
//        //User the connection
//        connection.query('DELETE FROM virtual_users WHERE id = ?', [req.params.id], (err, rows) => {
//            // When done with the connection, release it
//            connection.release();
//            if (!err) {
//                res.redirect('/');
//            } else {
//                console.log(err);
//            }
//            console.log('The data from user table: \n', rows);
//        });
//    });
//}

// delete user by switch active to removed
exports.delete = (req, res) => {
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);
        
        //User the connection
        connection.query('UPDATE virtual_users SET status = ? WHERE id = ?', ['removed', req.params.id], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                let removedUser = encodeURIComponent('User successfully removed.');
                res.redirect('/?removed=' + removedUser);
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}

// view user
exports.viewall = (req, res) => {
    pool.getConnection((err, connection) => {
        if (err) throw err;
        console.log('Connected as ID ' + connection.threadId);

        //User the connection
        connection.query('SELECT id, first_name, last_name, password as pass_word, email, comments FROM virtual_users WHERE id = ?', [req.params.id], (err, rows) => {
            // When done with the connection, release it
            connection.release();
            if (!err) {
                res.render('view-user', { rows });
            } else {
                console.log(err);
            }
            console.log('The data from user table: \n', rows);
        });
    });
}