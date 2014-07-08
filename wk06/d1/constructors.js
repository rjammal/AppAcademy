"use strict";

function Cat(name, owner) {
    this.name = name;
    this.owner = owner;
}

Cat.prototype.cuteStatement = function () {
    return this.owner + " loves " + this.name;
};

module.exports.Cat = Cat;


function Student(fName, lName) {
    this.fName = fName;
    this.lName = lName;
    
    this.courseLoad = ["this is my couyrse"];
}

function Course (name, department, numCredits) {
    this.name = name;
    this.department = department;
    this.numCredits = numCredits;
    
    this.enrolledStudents = [];
}

Student.prototype.enroll = function (course) {
    if (this.courseLoad.indexOf(course) === -1) {
        this.courseLoad.push(course);
        course.enrolledStudents.push(this);
    }
};

Student.prototype.courses = function () {
    return this.courseLoad;
};

Student.prototype.name = function () {
    return this.fName + " " + this.lName;
};

Student.prototype.courseCredits = function () {
    var depts = {};
    for (var i = 0; i < this.courseLoad.length; i++) {
        var dept = this.courseLoad[i].department; 
        if (typeof depts[dept] === 'undefined') {
            depts[dept] = this.courseLoad[i].numCredits;
        } else {
            depts[dept] += this.courseLoad[i].numCredits;
        }
    }
    return depts;
};

Course.prototype.students = function () {
    return this.enrolledStudents;
};

Course.prototype.addStudent = function (student) {
    student.enroll(this);
};

var s = new Student("Gabe", "Radovsky");
var c1 = new Course("Science 101", "Science", 4);
var c2 = new Course("Science 102", "Science", 45);
var c3 = new Course("Extreme Basket Weaving", "BS", 1);


s.enroll(c1);
s.enroll(c2);
s.enroll(c3);


console.log(s.courses());
console.log(s.courseCredits());
console.log(c2.enrolledStudents);