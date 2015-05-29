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
  this.op = function(operation) {
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

// Majors, or simply 150 padding on one or more sides
face.prototype.top_major        = function () { return this.h('screenSizeY-150').y('screenOriginY') }
face.prototype.bottom_major     = function () { return this.h('screenSizeY-150').y('screenOriginY+150') }
face.prototype.left_major       = function () { return this.w('screenSizeX-150').x('screenOriginX') }
face.prototype.right_major      = function () { return this.w('screenSizeX-150').x('screenOriginX+150') }

face.prototype.middle_major_col = function () { return this.w('screenSizeX-300').x('screenOriginX+150') }
face.prototype.middle_major_row = function () { return this.h('screenSizeY-300').y('screenOriginY+150') }


// Halfs
face.prototype.top_half         = function () { return this.h('screenSizeY/2').y('screenOriginY') }
face.prototype.bottom_half      = function () { return this.h('screenSizeY/2').y('screenOriginY+screenSizeY/2') }
face.prototype.left_half        = function () { return this.w('screenSizeX/2').x('screenOriginX')  }
face.prototype.right_half       = function () { return this.w('screenSizeX/2').x('screenSizeX/2+screenOriginX')  }

face.prototype.middle_half_col  = function () { return this.w('screenSizeX/2').x('screenSizeX/4+screenOriginX') }
face.prototype.middle_half_row  = function () { return this.h('screenSizeY/2').y('screenSizeY/4+screenOriginY') }


// Slivers, or simply 150 wide
face.prototype.top_sliver       = function () { return this.h(150).y('screenOriginY') }
face.prototype.bottom_sliver    = function () { return this.h(150).y('screenSizeY-150') }
face.prototype.left_sliver      = function () { return this.w(150).x('screenOriginX') }
face.prototype.right_sliver     = function () { return this.w(150).x('screenSizeX-150') }


// Majors
  // Sides
  S.bind('r:f5', O_().top_major().mv() );
  S.bind('d:f5', O_().left_major().mv() );
  S.bind('v:f5', O_().bottom_major().mv() );
  S.bind('g:f5', O_().right_major().mv() )

  // Middle Column
  S.bind('w:f5', O_().middle_major_col().mv() );

  // Middle Row
  S.bind('x:f5', O_().middle_major_row().mv() );

  // Center
  S.bind('f:f5', O_().middle_major_row().middle_major_col().mv() );

  // Corners
  S.bind('e:f5', O_().top_major().left_major().mv() );
  S.bind('c:f5', O_().left_major().bottom_major().mv() );
  S.bind('b:f5', O_().right_major().bottom_major().mv() );
  S.bind('t:f5', O_().top_major().right_major().mv() );


// Halfs
  // Sides
  S.bind('r:f6', O_().top_half().mv() );
  S.bind('d:f6', O_().left_half().mv() );
  S.bind('v:f6', O_().bottom_half().mv() );
  S.bind('g:f6', O_().right_half().mv() );

  // Middle Column
  S.bind('w:f6', O_().middle_half_col().mv() );

  // Middle Row
  S.bind('x:f6', O_().middle_half_row().mv() );

  // Center
  S.bind('f:f6', O_().middle_half_row().middle_half_col().mv() );

  // Corners
  S.bind('e:f6', O_().top_half().left_half().mv() );
  S.bind('c:f6', O_().left_half().bottom_half().mv() );
  S.bind('b:f6', O_().right_half().bottom_half().mv() );
  S.bind('t:f6', O_().top_half().right_half().mv() );


// Full
  S.bind('j:f6', O_().mv() );

// Slivers
  S.bind('u:f6', O_().top_sliver().mv() );
  S.bind('h:f6', O_().left_sliver().mv() );
  S.bind('m:f6', O_().bottom_sliver().mv() );
  S.bind('k:f6', O_().right_sliver().mv() );
