"use strict";

// function to test es6
let printName = (name) => {
    console.log(name.toUpperCase());
};

printName("deepak");

class Text {
    constructor(content) {
        this.content = content;
    }

    test() {
        console.log(this.content);
    }
}