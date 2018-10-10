package com.zomato.photofilters.geometry;

import java.awt.Point;

import org.omg.CORBA.Any;

/**
 * @author Varun on 29/06/15.
 */
public class Point {
    public float x;
    public float y;

    public Point(float x, float y) {
        this.x = x;
        this.y = y;
    }

    public static Point[] parseFromArrayPoints(float[][] pointArray) {
        Point[] points = new Point[pointArray.length];
        for (int i = 0; i < pointArray.length; i++) {
            points[i] = new Point(pointArray[i][0], pointArray[i][1]);
        }
        return points;
    }
}
