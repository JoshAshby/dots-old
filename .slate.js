S.configAll({
  "defaultToCurrentScreen": true,
  "nudgePercentOf": "screenSize",
  "resizePercentOf": "screenSize",
  "keyboardLayout": "qwerty"
});

S.bind('delete:f6', S.op("relaunch") );

// A weird little microframework for slate.
//
// Because I was bored and really sleepy today. =|
function O_() { return new face() }
function face() {
  this.hsh = {};
  this.stack = [];

  // Slate executes javascript ahead of time unless you bind an action to a closure.
  // As such, we want to actually execute much later than when creating key bindings,
  // so that we can do more advanced operations.
  //
  // These wrappers provide a syntactic sugar which creates closures that modify
  // a windows position and size.
  this.x   = function(n){ this.stack.push( function(){ this.hsh.x = n;      }); return this; };
  this.y   = function(n){ this.stack.push( function(){ this.hsh.y = n;      }); return this; };
  this.w   = function(n){ this.stack.push( function(){ this.hsh.width  = n; }); return this; };
  this.h   = function(n){ this.stack.push( function(){ this.hsh.height = n; }); return this; };
  this.s   = function(n){ this.stack.push( function(){ this.hsh.screen = n; }); return this; };

  // These more meta functions dont need to push anything to the transform stack directly
  // since they just call the helpers above directly.
  this.full = function( ){ return this.x('screenOriginX').y('screenOriginY').w('screenSizeX').h('screenSizeY') }
  this.fin  = function( ){ return this.hsh; };
  this.log  = function( ){ S.log("{x:" + this.hsh.x + ", y:" + this.hsh.y + ", w:" + this.hsh.width + ", h:" + this.hsh.height + ", s:" + (this.hsh.screen == null ? 'nil' : this.hsh.screen) + "}"); };

  // Shortcuts for different actions
  this.mv = function( ){ S.log('creating closure'); return this.op('move'); }

  // Essentially a private function, you probably shouldn't be calling this.
  // This provides a closure for Slate to execute when bound to a hotkey.
  // Inside the closure, we execute the transformation stack to build the hash
  // and then pass that has on to window.doOperation.
  this.op = function(operation){
    var that = this;
    return (
        function(win) {
          for (var i=0; i < that.stack.length; i ++)
            that.stack[i].call(that);

          win.doOperation(operation, that.fin());
        }
    );
  }

  this.full();
  return this;
}

// Workstation specific extensions for me
face.prototype.top_major     = function () { return this.h('screenSizeY-150').y('screenOriginY') }
face.prototype.bottom_major  = function () { return this.h('screenSizeY-150').y('screenOriginY+150') }
face.prototype.left_major    = function () { return this.w('screenSizeX-150').x('screenOriginX') }
face.prototype.right_major   = function () { return this.w('screenSizeX-150').x('screenOriginX+150') }
face.prototype.middle_major  = function () { return this.w('screenSizeX-300').x('screenOriginX+150') }

face.prototype.top_minor     = function () { return this.h(150).y('screenOriginY') }
face.prototype.bottom_minor  = function () { return this.h(150).y('screenSizeY-150') }
face.prototype.left_minor    = function () { return this.w(150).x('screenOriginX') }
face.prototype.right_minor   = function () { return this.w(150).x('screenSizeX-150') }

face.prototype.top_half     = function () { return this.h('screenSizeY/2').y('screenOriginY') }
face.prototype.bottom_half  = function () { return this.h('screenSizeY/2').y('screenOriginY+screenSizeY/2') }
face.prototype.left_half    = function () { return this.w('screenSizeX/2').x('screenOriginX')  }
face.prototype.right_half   = function () { return this.w('screenSizeX/2').x('screenSizeX/2+screenOriginX')  }
face.prototype.middle_half  = function () { return this.w('screenSizeX/2').x('screenSizeX/4+screenOriginX') }

// Full and Center
S.bind('f:f6', O_().mv() );
S.bind('f:f5', O_().middle_major().h('screenSizeY-300').y('screenOriginY+150').mv() );

// Middles
S.bind('m:f6', O_().middle_half().mv() );
S.bind('m:f5', O_().middle_major().mv() );

// Majors
S.bind('y:f5', O_().top_major().mv() );
S.bind('b:f5', O_().bottom_major().mv() );
S.bind('g:f5', O_().left_major().mv() );
S.bind('h:f5', O_().right_major().mv() );

// Minors
S.bind('e:f5', O_().top_minor().mv() );
S.bind('x:f5', O_().bottom_minor().mv() );
S.bind('s:f5', O_().left_minor().mv() );
S.bind('d:f5', O_().right_minor().mv() );

// Halfs
S.bind('y:f6', O_().top_half().mv() );
S.bind('b:f6', O_().bottom_half().mv() );
S.bind('g:f6', O_().left_half().mv() );
S.bind('h:f6', O_().right_half().mv() );

//Corners
S.bind('t:f6', O_().top_half().left_half().mv() );
S.bind('v:f6', O_().left_half().bottom_half().mv() );
S.bind('u:f6', O_().top_half().right_half().mv() );
S.bind('n:f6', O_().right_half().bottom_half().mv() );