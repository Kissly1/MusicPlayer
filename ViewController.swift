import UIKit
import AVFoundation

struct Track {
    let title: String
    let artist: String
    let fileName: String
    let cover: String
}

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumCoverImageView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var playPauseButton: UIButton!
    
    // MARK: - Audio
    var player: AVAudioPlayer?
    var timer: Timer?
    
    // MARK: - Tracks list
    var tracks: [Track] = [
        Track(title: "Training Season", artist: "Dua Lipa", fileName: "track1", cover: "cover1"),
        Track(title: "Москва любит...", artist: "Скриптонит", fileName: "track2", cover: "cover2"),
        Track(title: "Ночная хроника", artist: "Ямыч Восточный Округ, Гио Пика", fileName: "track3", cover: "cover3"),
        Track(title: "Indian Rap", artist: "Indian Rapper", fileName: "track4", cover: "cover4"),
        Track(title: "Stil D.R.E", artist: "Dr. D.R.E, Snopp Dogg", fileName: "track5", cover: "cover5")
    ]
    
    var currentIndex = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadTrack(index: currentIndex)
    }
    
    // MARK: - Load Track
    func loadTrack(index: Int) {
        let track = tracks[index]
        
        // Обновление UI
        trackTitleLabel.text = track.title
        artistNameLabel.text = track.artist
        albumCoverImageView.image = UIImage(named: track.cover)
        
        // Загрузка аудио
        guard let url = Bundle.main.url(forResource: track.fileName, withExtension: "mp3") else {
            print("Файл \(track.fileName) не найден")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            
            progressSlider.minimumValue = 0
            progressSlider.maximumValue = Float(player?.duration ?? 0)
            progressSlider.value = 0
            
            durationLabel.text = formatTime(player?.duration ?? 0)
            currentTimeLabel.text = "0:00"
            
        } catch {
            print("Ошибка загрузки аудио: \(error.localizedDescription)")
        }
    }
    
    // MARK: - UI Setup
    func setupUI() {
        albumCoverImageView.layer.cornerRadius = 12
        albumCoverImageView.clipsToBounds = true
        
        playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
    }
    
    // MARK: - Play / Pause
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.pause()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            timer?.invalidate()
        } else {
            player.play()
            sender.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            startTimer()
        }
    }
    
    // MARK: - Next / Previous buttons
    @IBAction func nextTapped(_ sender: UIButton) {
        currentIndex += 1
        if currentIndex >= tracks.count {
            currentIndex = 0
        }
        
        loadTrack(index: currentIndex)
        player?.play()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        startTimer()
    }
    
    @IBAction func prevTapped(_ sender: UIButton) {
        if currentIndex == 0 {
            currentIndex = tracks.count - 1
        } else {
            currentIndex -= 1
        }
        
        loadTrack(index: currentIndex)
        player?.play()
        playPauseButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        startTimer()
    }
    
    // MARK: - Slider change
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        guard let player = player else { return }
        player.currentTime = TimeInterval(sender.value)
        currentTimeLabel.text = formatTime(TimeInterval(sender.value))
    }
    
    // MARK: - Timer
    func startTimer() {
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self, let player = self.player else { return }
            
            self.progressSlider.value = Float(player.currentTime)
            self.currentTimeLabel.text = self.formatTime(player.currentTime)
            
            if player.currentTime >= player.duration {
                self.timer?.invalidate()
                self.playPauseButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
                self.progressSlider.value = 0
                self.currentTimeLabel.text = "0:00"
            }
        }
    }
    
    // MARK: - Format Time
    func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
