"use strict";

// function to test es6
let log = (message) => {
    console.log(message);
};

class ArcInputForm {

    constructor() {
        this.commands = [];
        this.textarea = document.getElementById('arc-text-input');
        this.screen   = document.getElementById('arc-text-output');
        this.active_commands = document.getElementById('arc-active-commands');

        let obj = this;

        $('.arc-action').on('click', (e) => {
            obj.addCommand(e.target.dataset.command);
            obj.setActiveCommandsView()
        });

        $('#arc-clear').on('click', (e) => {
            obj.clearCommands();
            obj.setActiveCommandsView();
        });


        $('#arc-submit').on('click', (e) => {
            let data = {
                commands: obj.commandString,
                text: obj.inputText
            };

            $.ajax({
                type: 'POST',
                url: '/api/v1/text_operations/run_commands',
                data: data,
                success: function(data){ obj.submitCallback(data) },
                error: function (err) {
                    console.log("Network error: Unable to connect");
                },
                dataType: 'json'
            });
        });
    }

    get commandString() {
        return this.commands.join('|');
    }

    addCommand(cmd) {
        if (!this.commands.includes(cmd)) {
            this.commands.push(cmd);
        }
    }

    clearCommands() {
        this.commands = [];
    }

    get inputText() {
        return this.textarea.value;
    }

    set inputText(text) {
        this.textarea.value = text;
    }

    set outputScreen(text) {
        this.screen.innerText = text;
    }

    setActiveCommandsView() {
        this.active_commands.innerText = this.commands.join('|');
    }

    submitCallback(data) {
        if (data.status == 'ok') {
            this.outputScreen = data.data;
        } else if (data.status == 'error') {
            alert(data.message);
        } else {
            alert(data.message);
        }
    }
}

$(document).ready( () => {
        new ArcInputForm();
    }
);
