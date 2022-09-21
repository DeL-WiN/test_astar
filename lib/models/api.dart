import 'dart:ffi';
import 'dart:ffi';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:untitled5/models/models.dart';
import 'package:dijkstra/dijkstra.dart';
import '../bloc/cubit.dart';

class ApiWelcome {
  ApiWelcome();

  Future<Welcome?> getHttp() async {
    try {
      var response =
      await Dio().get('https://flutter.webspark.dev/flutter/api');
      Map<String, dynamic> post = response.data;
      final posts = Welcome.fromJson(post);
      print('111');
      return posts;
    } catch (e) {
      print(e);
    }
  }

  // Future<void> way() async {
  //   final rec = await getHttp();
  //   final start = rec?.data[0].start;
  //   final end = rec?.data[0].end;
  //   final field = rec?.data[0].field;
  //   var res = [];
  //   for (var x = 0; field!.length > x; x++) {
  //     final str = rec?.data[0].field[x].split("");
  //     for (var y = 0; str!.length > y; y++) {
  //       if (start!.x <= x && start.y <= y) {
  //         res.add({x: x, y: y});
  //       }
  //       if (end!.x <= x && end.y <= y) {
  //         res.add({x: x, y: y});
  //       }
  //       // print('xy , $x,$y , ${str[y]} , ${str[x]}');
  //     }
  //   }
  //   // var output1 = Dijkstra.findPathFromPairsList(res, start, end);
  //   // var output2 = Dijkstra.findPathFromGraph(res, start, end);
  //   // print(output1);
  // }

void graph () async {
  // final rec = await getHttp();
  var graphDiagonal = [
    [1,1,1,1],
    [0,1,1,0],
    [0,0,1,1]
  ];
  var start = graphDiagonal[0][0];
  var end = graphDiagonal[1][2];
  var resultWithDiagonals = ApiWelcome().search(graphDiagonal, start, end);
  print(resultWithDiagonals);
}

  double diagonal (pos0, pos1) {
    var D = 1;
    var D2 = sqrt(2);
    var d1 = ((pos1.x - pos0.x).abs);
    var d2 = ((pos1.y - pos0.y).abs);
    return (D * (d1 + d2)) + ((D2 - (2 * D)) * min(d1, d2));
  }

   init(grid) {
     for (var x = 0; x < grid.length; x++) {
       for (var y = 0; y < grid[x].length; y++) {
         grid[x][y].f = 0;
         grid[x][y].g = 0;
         grid[x][y].h = 0;
         grid[x][y].visited = false;
         grid[x][y].closed = false;
         grid[x][y].debug = "";
         grid[x][y].parent = null;
       }
     }
   }


    List search(grid, start, end,) {
      ApiWelcome().init(grid);


      var openList = [];
      openList.add(start);

      while (openList.length > 0) {
        var lowInd = 0;
        for (var i = 0; i < openList.length; i++) {
          if (openList[i].f < openList[lowInd].f) {
            lowInd = i;
          }
        }
        var currentNode = openList[lowInd];

        if (currentNode == end) {
          var curr = currentNode;
          var ret = [];
          while (curr.parent) {
            ret.add(curr);
            curr = curr.parent;
          }
          return ret;
        }

        openList.remove(lowInd);
        currentNode.closed = true;

        var neighbors = ApiWelcome().neighbors(grid, currentNode);
        for (var i = 0; i < neighbors.length; i++) {
          var neighbor = neighbors[i];

          if (neighbor.closed || neighbor.isWall()) {
            continue;
          }

          var gScore = currentNode.g + 1;
          var gScoreIsBest = false;

          if (!neighbor.visited) {
            gScoreIsBest = true;
            neighbor.h = diagonal(neighbor.pos, end.pos);
            neighbor.visited = true;
            openList.add(neighbor);
          }
          else if (gScore < neighbor.g) {
            gScoreIsBest = true;
          }
          if (gScoreIsBest) {
            neighbor.parent = currentNode;
            neighbor.g = gScore;
            neighbor.f = neighbor.g + neighbor.h;
            // neighbor.debug ="F: " + neighbor.f + "<br />G: " + neighbor.g + "<br />H: " + neighbor.h;
          }
        }
      }
      print('sdsd');
      return [];
    }

    List neighbors(grid, node) {
      var ret = [];
      var x = node.x;
      var y = node.y;
      print('reer');
      if (grid[x - 1] && grid[x - 1][y]) {
        ret.add(grid[x - 1][y]);
      }
      if (grid[x + 1] && grid[x + 1][y]) {
        ret.add(grid[x + 1][y]);
      }
      if (grid[x][y - 1] && grid[x][y - 1]) {
        ret.add(grid[x][y - 1]);
      }
      if (grid[x][y + 1] && grid[x][y + 1]) {
        ret.add(grid[x][y + 1]);
      }
      print('object');
      print(neighbors(grid, node));
      print('xy , $x,$y , ${ret[y]} , ${ret[x]}');
      print('reer');
      return ret;
    }
  }



