Array.prototype.includes = function (val) {
  var returnValue = false;
  this.forEach(function (el, i){
    if (val === el) {
      returnValue = true;
    }
  });
  return returnValue;
};

var Student = function(name){
  this.name = name;
  this.courses = [];
  this.enroll = function(course) {
    if (!this.courses.includes(course)) {
      this.courses.push(course);
      course.add_student(this);
    }
  };
}

var Course = function(name, department, numCredits) {
  this.name = name;
  this.department = department;
  this.numCredits = numCredits;
  this.students = [];
  this.add_student = function(student){
    this.students.push(student);
  };
}
