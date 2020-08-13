module Main where

{-

Requirements
------------
* The application will take a directed acyclic graph, a starting vertex, and a
  destination vertex and calculate the shortest path from the start to the
  destination
 * The graph will have a single designated entry point
 * The graph will have a single desigated terminal point
 * The graph may contain disjoint subgraphs
* The application will listen and accept connections on TCP 127.0.0.1:7777
* Upon establishing a connection with a client the application will read the
  starting vertex, destination vertex, and graph from the client file
  descriptor in the format specified under the Input section and write the
  shortest path and distance out over the client file descriptor in the format
  specified under the Output section
 * The input format is guaranteed, and therefore, undefined behaviour for
   invalid input is acceptable


Input Format
------------

* The binary input data's endianness is little-endian. If you are developing on
  an x86 system, you do not have to worry about this.
* The binary input data is split into two-byte fields
* Each field is a sixteen bit unsigned integer in the set: {1,2,...,65535}
 * Zero is an invalid input; it can be assumed that no field will be set to 0
* There are no delimiters between the fields
* The first and second bytes of the file represent the entry vertex of the graph
* The third and forth bytes of the file represent the terminal vertex of the graph
* The fifth and sixth bytes represent the number of edges
* The remainder of the file is as described below:
  * Each field is 6 bytes wide and represents a single edge
  * Each edge is directed
  * Each edge field is split into three sub-fields
   * The first two-byte field is the ID of the source vertex of the edge
   * The second two-byte field a ID of the destination vertex of the edge
   * The third two-byte field is the cost to traverse the edge

Sample Input Data
-----------------

     # Decimal Representation of Binary File
     1  5   9
     1  2  14
     1  3   9
     1  4   7
     2  5   9
     3  2   2
     3  6  11
     4  3  10
     4  6  15
     6  5   6

     # Hexadecimal Representation of Binary File
     0100 0500 0900
     0100 0200 0e00
     0100 0300 0900
     0100 0400 0700
     0200 0500 0900
     0300 0200 0200
     0300 0600 0b00
     0400 0300 0a00
     0400 0600 0f00
     0600 0500 0600


Output Format
-------------

* The output will written to the client file descriptor as a string in the
  following format:

          start_vertex->vertex->destination_vertex (distance)
* If there is no path from the starting vertex to the destination vertex the
  result should be in the following format:

          No path from 'start_vertex' to 'destination_vertex'


Sample Output Data
------------------

     # Correct output for sample input data above
     1->3->2->5 (20)

     # Correct output for map with no path from start (1) to destination (2)
     No path from '1' to '2'

-}

import qualified Data.ByteString.Lazy as BL
import Data.Binary.Get


data InputDAG = InputDAG {
    entryPoint :: []
  , terminal :: []
  , numberOfEdges :: []
  , edges :: []
}


main :: IO ()
main = putStrLn "Hello, Haskell!"
