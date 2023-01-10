import   'package:flutter/material.dart';

void main() => runApp(MaterialApp(
   home: TicTacToeApp(),

  ),
);

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',

      home: TicTacToeHome(),
    );
  }
}

class TicTacToeHome extends StatefulWidget {
  @override
  _TicTacToeHomeState createState() => _TicTacToeHomeState();
}

class _TicTacToeHomeState extends State<TicTacToeHome> {
  // Game state variables
  late List<List<String>>  _board;
  late String  _currentPlayer;
  late bool  _gameOver;
  late String   _winner;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  // Function to initialize the game state
  void _initializeGame() {
    // Set up initial game state
    _board = [
      ['', '', ''],
      ['', '', ''],
      ['', '', ''],
    ];
    _currentPlayer = 'X';
    _gameOver = false;
    _winner = '';
  }

  // Function to handle a move by the current player
  void _handleMove(int row, int col) {
    // Do nothing if the game is over or the selected square is not empty
    if (_gameOver || _board[row][col] != '') {
      return;
    }

    // Make the move
    setState(() {
      _board[row][col] = _currentPlayer;
    });

    // Check if the game is over
    if (_isGameOver()) {
      setState(() {
        _gameOver = true;
        _winner = _currentPlayer;
      });
    } else {
      // Switch to the other player
      _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
    }
  }

  // Function to check if the game is over
  bool _isGameOver() {
    // Check rows
    for (int row = 0; row < 3; row++) {
      if (_board[row][0] != '' &&
          _board[row][0] == _board[row][1] &&
          _board[row][1] == _board[row][2]) {
        return true;
      }
    }

    // Check columns
    for (int col = 0; col < 3; col++) {
      if (_board[0][col] != '' &&
          _board[0][col] == _board[1][col] &&
          _board[1][col] == _board[2][col

          ]) {
        return true;
      }
    }

    // Check diagonals
    if (_board[0][0] != '' &&
        _board[0][0] == _board[1][1] &&
        _board[1][1] == _board[2][2]) {
      return true;
    }
    if (_board[0][2] != '' &&
        _board[0][2] == _board[1][1] &&
        _board[1][1] == _board[2][0]) {
      return true;
    }

    // If no winner was found, check if the board is full
    for (int row = 0; row < 3; row++) {
      for (int col = 0; col < 3; col++) {
        if (_board[row][col] == '') {
          return false;
        }
      }
    }

    // If the code reaches this point, the game is a draw
    return true;
  }

  // Function to reset the game
  void _resetGame() {
    setState(() {
      _initializeGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
      ),
      body:  Container(

          color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(20.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: 9,
                    itemBuilder: (context, index) {
                      int row = index ~/ 3;
                      int col = index % 3;
                      return GestureDetector(
                        onTap: () => _handleMove(row, col),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(17),
                            border: Border.all(

                              color: Colors.red,

                              width: 2.0,
                            ),
                            color: Colors.yellow,
                          ),
                          child: Center(
                            child: Text(
                              _board[row][col],
                              style: TextStyle(
                                fontSize: 72.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                _gameOver
                    ? Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                  children: [

                      Text('Winner is : $_winner',
                       style: TextStyle(
                         fontSize: 30,
                         color: Colors.yellowAccent,
                       ),),
                      ElevatedButton(

                        child:

                        Text('Reset', style: TextStyle(
                           fontSize: 21,
                           color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),),
                        onPressed: _resetGame,
                      ),
                  ],
                ),
                    )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
