//
//  ViewController.swift
//  ConstraintAnimation
//
//  Created by user on 2022/05/23.
//

import UIKit
import SnapKit

class TouchView: UIView {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(self)
    }
}

class ViewController: UIViewController {

    private let toggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()

    private let containerView: TouchView = {
        let view = TouchView()
        view.backgroundColor = .yellow
        return view
    }()

    private let someView: TouchView = {
        let view = TouchView()
        view.backgroundColor = .orange
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(toggle)
        toggle.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-200)
            make.centerX.equalToSuperview()
        }
        toggle.addTarget(self, action: #selector(toggleDidToggled), for: .valueChanged)

        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.height.width.equalTo(100)
        }

        containerView.addSubview(someView)
        someView.snp.makeConstraints { make in
            make.centerX.centerY.height.width.equalToSuperview()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(self)
    }

    @objc private func toggleDidToggled(_ sender: UISwitch) {
        if sender.isOn {
            someView.snp.updateConstraints { make in
                make.centerY.equalToSuperview()
            }
            containerView.isUserInteractionEnabled = true
        } else {
            someView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(1200)
            }
            containerView.isUserInteractionEnabled = false
        }

        UIView.animate(
            withDuration: 0.25,
            delay: 0.1,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: { [weak self] in self?.containerView.layoutIfNeeded() }
        )
    }
}
