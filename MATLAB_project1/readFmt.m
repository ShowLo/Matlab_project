%第六题，播放fmt.wav
clear all;close all;clc;
[y,Fs] = audioread('fmt.wav');
sound(y,Fs);