# Notifier
1. Using RTObserver protocol to uniform the behaviors in notification & KVO 
2. Register observer with block
3. Unregister the observing action automatically when the observer deallocs
4. For KVO, when the observed object deallocs, it will remove the observers automatically

# Usage
```OC
//hold the observer returned by strong reference.
self.observer1 = [self.model observerForKeyPath:@"title" withBlock:^(id changes){}];
[self.observer1 startObserve];

//stop observing
[self.observer1 stopObserve]; //invoke [self.observer1 startObserve] to observe again
/**
 * OR
 */
self.observer1 = nil; //self.observer1 = [...] if you want to observe again

self.model == nil; //stop observing as the observed object deallocs automatically
```
