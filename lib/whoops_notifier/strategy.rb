module WhoopsNotifier
  class Strategy
    # ask witnesses for data, create a report using a strategy, send or ignore
    attr_accessor :name, :ignore_criteria, :report_modifiers

    def initialize(name)
      self.name             = name
      self.ignore_criteria  = []
      self.report_modifiers = []
    end
    
    def apply(investigator)
      report_modifiers.each do |report_modifier|
        report_modifier.call(investigator)
      end
      
      ignore_criteria.each do |ignore_criterion|
        if ignore_criterion.call(investigator.report)
          investigator.ignore_report = true
          break
        end
      end
    end
    
    def add_report_modifier(name, &block)
      give_name(name, block)
      @report_modifiers << block
    end

    def add_ignore_criterion(name, &block)
      give_name(name, block)
      @ignore_criteria << block
    end
    
    def give_name(name, block)
      class << block
        attr_accessor :name
      end
      block.name = name
    end    
  end
end