var currentPhase;

function phaseIn(element) {
  if(currentPhase) {
    currentPhase.cancel();

    if(currentPhase.element != element)
      phaseOut(currentPhase.element);
  }

  currentPhase = new Effect.Opacity(element, { from: element.getStyle('opacity'), to: 0.7, duration: 0.3 });
}

function phaseOut(element) {
  if(currentPhase)
    currentPhase.cancel();

  currentPhase = new Effect.Opacity(element, { from: element.getStyle('opacity'), to: 0, duration: 0.3 });
}

