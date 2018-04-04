class Analyzer
  attr_reader :data

  def initialize
    @data = {}
  end

  def pair_data(lines)
    split_lines      = lines.split(' ')
    data['Verb']     = split_lines[1]
    data['Path']     = split_lines[3]
    data['Protocol'] = split_lines[5]
    data['Host']     = split_lines[7]
    data['Port']     = split_lines[9]
    data['Origin']   = split_lines[11]
    data['Accept']   = split_lines[13] << ' ' << split_lines[14]
  end

  def diagnostic_info
  %(
    <pre>
    Verb: #{data['Verb']}
    Path: #{data['Path']}
    Protocol: #{data['Protocol']}
    Host: #{data['Host']}
    Port: #{data['Port']}
    Origin: #{data['Origin']}
    Accept: #{data['Accept']}
    </pre>)
  end
end
