function PerfectDragSimple(vElement, fnOnDragStart, fnOnDraging,fnOnDragEnd) {
	var oElementDrag = null;
	if (typeof vElement == 'string') {
		oElementDrag = document.getElementById(vElement);
	}else if (typeof vElement == 'object') {
		oElementDrag = vElement;
	}
	this.creator = PerfectDrag;
	this.creator(oElementDrag, function() {
		return {
			x : oElementDrag.offsetLeft,
			y : oElementDrag.offsetTop
		};
	}, function(x, y) {
		oElementDrag.style.left = x + 'px';
		oElementDrag.style.top = y + 'px';

		if (fnOnDraging) {
			fnOnDraging(x, y);
		}
	}, fnOnDragStart, fnOnDragEnd);
	delete this.creator;
}
PerfectDragSimple.prototype = PerfectDrag.prototype;

function PerfectDrag(oElementDrag, fnGetPos, fnDoMove, fnOnDragStart,fnOnDragEnd) {
	var obj = this;
	this.oElement = oElementDrag;
	this.oElement.style.overflow = 'hidden';
	this.fnGetPos = fnGetPos;
	this.fnDoMove = fnDoMove;
	this.fnOnDragStart = fnOnDragStart;
	this.fnOnDragEnd = fnOnDragEnd;
	this.__oStartOffset__ = {
		x : 0,
		y : 0
	};
	this.oElement.onmousedown = function(ev) {
		obj.startDrag(window.event || ev);
	};
	this.fnOnMouseUp = function(ev) {
		obj.stopDrag(window.event || ev);
	};
	this.fnOnMouseMove = function(ev) {
		obj.doDrag(window.event || ev);
	};
}

PerfectDrag.prototype.enable = function() {
	var obj = this;

	this.oElement.onmousedown = function(ev) {
		obj.startDrag(window.event || ev);
	};
};

PerfectDrag.prototype.disable = function() {
	this.oElement.onmousedown = null;
};

PerfectDrag.prototype.startDrag = function(oEvent) {
	var oPos = this.fnGetPos();
	var x = oEvent.clientX;
	var y = oEvent.clientY;
	if (this.fnOnDragStart) {
		this.fnOnDragStart();
	}
	this.__oStartOffset__.x = x - oPos.x;
	this.__oStartOffset__.y = y - oPos.y;
	if (this.oElement.setCapture) {
		this.oElement.setCapture();
		this.oElement.onmouseup = this.fnOnMouseUp;
		this.oElement.onmousemove = this.fnOnMouseMove;
	} else {
		document.addEventListener("mouseup", this.fnOnMouseUp, true);
		document.addEventListener("mousemove", this.fnOnMouseMove, true);
		window.captureEvents(Event.MOUSEMOVE | Event.MOUSEUP);
	}
};

PerfectDrag.prototype.stopDrag = function(oEvent) {
	if (this.oElement.releaseCapture) {
		this.oElement.releaseCapture();
		this.oElement.onmouseup = null;
		this.oElement.onmousemove = null;
	} else {
		document.removeEventListener("mouseup", this.fnOnMouseUp, true);
		document.removeEventListener("mousemove", this.fnOnMouseMove, true);
		window.releaseEvents(Event.MOUSE_MOVE | Event.MOUSE_UP);
	}
	if (this.fnOnDragEnd) {
		if (oEvent.clientX == this.__oStartOffset__.x
				&& oEvent.clientY == this.__oStartOffset__.y) {
			this.fnOnDragEnd(false);
		} else {
			this.fnOnDragEnd(true);
		}
	}
};

PerfectDrag.prototype.doDrag = function(oEvent) {
	var x = oEvent.clientX;
	var y = oEvent.clientY;
	this.fnDoMove(x - this.__oStartOffset__.x, y - this.__oStartOffset__.y);
};

var oTimer = null;
var iSpeed = 0;
var iNow = 0;
function perfectDrag() {
	var oPanelList = document.getElementById('panel_list');
	var iStartX = 0;
	new PerfectDrag(oPanelList, function() {
		return {
			x : oPanelList.offsetLeft,
			y : oPanelList.offsetTop
		};
	}, function(x, y) {
		oPanelList.style.left = x + 'px';
		// oPanelList.style.top=y+'px';
	}, function() {
		stopMove();
		iStartX = oPanelList.offsetLeft;
	}, function() {// 当拖拽结束
		if (Math.abs(oPanelList.offsetLeft - iStartX) >= 50) {
			if (oPanelList.offsetLeft > iStartX) {
				iNow--;
				if (iNow < 0) {
					iNow = 0;
				}
			} else {
				iNow++;
				if (iNow >= oPanelList.childNodes.length) {
					iNow = oPanelList.childNodes.length - 1;
				}
			}
		}
		startMove(-iNow * oPanelList.document.getElementById('panel').offsetWidth);
	});

	perfectWheel();
};

/**
 * 鼠标滚动事件
 */
function perfectWheel() {
	var wheel = function(event) {
		var delta = 0;
		if (!event)
			event = window.event;
		if (event.wheelDelta) {
			delta = event.wheelDelta / 120;
		} else if (event.detail) {
			delta = -event.detail / 3;
		}
		if (delta) {
			handle(delta);
		}
		if (event.preventDefault)
			event.preventDefault();
		event.returnValue = false;
	};

	if (window.addEventListener) {
		window.addEventListener('DOMMouseScroll', wheel, false);
	}
	window.onmousewheel = document.onmousewheel = wheel;

	var oPanelList = document.getElementById('panel_list');
	var handle = function(delta) {
		if (delta > 0) {// 鼠标滑轮向上滚动
			iNow--;
			if (iNow < 0) {
				iNow = 0;
			}
		} else {// 鼠标滑轮向下滚动
			iNow++;
			if (iNow >= oPanelList.childNodes.length) {
				iNow = oPanelList.childNodes.length - 1;
			}
		}
		startMove(-iNow
				* oPanelList.document.getElementById('panel').offsetWidth);
	};
};

function startMove(iTarget) {
	if (oTimer) {
		clearInterval(oTimer);
	}
	oTimer = setInterval("doMove(" + iTarget + ")", 30);
}

function doMove(iTarget) {
	var oPanelList = document.getElementById('panel_list');
	var l = oPanelList.offsetLeft;

	iSpeed += (iTarget - oPanelList.offsetLeft) / 5;
	iSpeed *= 0.7;
	l += iSpeed;
	if (Math.abs(iTarget - oPanelList.offsetLeft) < 1 && Math.abs(iSpeed) < 1) {
		clearInterval(oTimer);
		oTimer = null;
		l = iTarget;
	}
	oPanelList.style.left = l + 'px';
}

function stopMove() {
	if (oTimer) {
		clearInterval(oTimer);
	}
}
