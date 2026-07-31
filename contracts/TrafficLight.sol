// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract TrafficLight {
    enum Light{
        Red,
        Yellow,
        Green
    }

    Light public currentLight;

    function goGreen() public  {
        currentLight = Light.Green;
    }

    function goYellow() public {
        currentLight = Light.Yellow;
    }

    function goRed() public {
        currentLight = Light.Red;
    }
}