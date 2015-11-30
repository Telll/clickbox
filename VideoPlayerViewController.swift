//
//  VideoPlayerViewController.swift
//  TelllClient
//
//  Created by Fernando Oliveira on 28/11/15.
//  Copyright © 2015 FCO. All rights reserved.
//

import AVKit
import AVFoundation

class VideoPlayerViewController: UIViewController {
    
    var movie : Movie = Movie(origJson: [])
    var moviePlayer : AVPlayerViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url : NSURL = NSURL(string: "http://jplayer.org/video/m4v/Big_Buck_Bunny_Trailer.m4v")!
        self.moviePlayer = AVPlayerViewController()
        
        if let player = self.moviePlayer {
            
            player.player = AVPlayer(URL: movie.url)
            
            player.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            player.view.sizeToFit()
            
            /* Scale the movie player to fit the aspect ratio */

//            player.player.scalingMode = .AspectFit
//            player.player.controlStyle = MPMovieControlStyle.None
//            player.player.movieSourceType = MPMovieSourceType.File; player.repeatMode = MPMovieRepeatMode.One;
            player.player!.play()
            
            self.view.addSubview(player.view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoPlayerViewController : AVPlayerViewControllerDelegate {
    
    /// playerViewController will start PIP
    func playerViewControllerWillStartPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP will start")
    }
    
    /// playerViewController did start PIP
    func playerViewControllerDidStartPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP did start")
    }
    
    /// playerViewController will stop PIP
    func playerViewControllerWillStopPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP will stop")
    }
    
    /// playerViewController did stop PIP
    func playerViewControllerDidStopPictureInPicture(playerViewController: AVPlayerViewController) {
        print("PIP did stop")
    }
    
    /// playerViewController failed to start PIP
    func playerViewController(playerViewController: AVPlayerViewController, failedToStartPictureInPictureWithError error: NSError) {
        print("PIP Error : \(error.localizedDescription)")
    }
    
    /// playerViewController automatically dismiss at PIP Start.
    func playerViewControllerShouldAutomaticallyDismissAtPictureInPictureStart(playerViewController: AVPlayerViewController) -> Bool {
        return false
    }
    
    /// playerViewController restore Interface For PIP
    func playerViewController(playerViewController: AVPlayerViewController, restoreUserInterfaceForPictureInPictureStopWithCompletionHandler completionHandler: (Bool) -> Void) {
        
        // if topView and navigation controller :
        if let topViewController = navigationController?.topViewController {
            topViewController.presentViewController(playerViewController, animated: true) {
                print("ready detailvc restore presentViewController")
                completionHandler(true)
            }
        }
        else {
            completionHandler(false)
        }
    }
}
