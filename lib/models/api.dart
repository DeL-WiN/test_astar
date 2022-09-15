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
      return posts;
    } catch (e) {
      print(e);
    }
  }

  Future<void> way() async {
    final rec = await getHttp();
    final start = rec?.data[0].start;
    final end = rec?.data[0].end;
    final field = rec?.data[0].field;
    var res = [];
    for (var x = 0; field!.length > x; x++) {
      final str = rec?.data[0].field[x].split("");
      for (var y = 0; str!.length > y; y++) {
        if (start!.x <= x && start.y <= y) {
          res.add({x: x, y: y});
        }
        if (end!.x <= x && end.y <= y) {
          res.add({x: x, y: y});
        }
        // print('xy , $x,$y , ${str[y]} , ${str[x]}');
      }
    }
    // var output1 = Dijkstra.findPathFromPairsList(res, start, end);
    // var output2 = Dijkstra.findPathFromGraph(res, start, end);
    // print(output1);
  }

  void init(grid) {
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


    List search(grid, start, end, heuristic) {
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
            neighbor.h = heuristic(neighbor.pos, end.pos);
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
            neighbor.debug =
                "F: " + neighbor.f + "<br />G: " + neighbor.g + "<br />H: " +
                    neighbor.h;
          }
        }
      }
      return [];
    }

    void manhattan(pos0, pos1) {
      var d1 = pos1.x - pos0.x;
      var d2 = pos1.y - pos0.y;
      return d1 + d2;
    }

    List neighbors(grid, node) {
      var ret = [];
      var x = node.x;
      var y = node.y;

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
      print(ret);
      return ret;
    }
  }




